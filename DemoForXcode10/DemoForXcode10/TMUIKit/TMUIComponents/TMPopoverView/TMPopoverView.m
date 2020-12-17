//
//  TMPopoverView.m
//  Masonry
//
//  Created by nigel.ning on 2020/6/22.
//

#import "TMPopoverView.h"
#import <Masonry/Masonry.h>
#import "TMUICore.h"
#import "TMUIExtensions.h"
#import "TMUIWeakObjectContainer.h"
#import <objc/runtime.h>


@interface TMPopoverView()
@property (nonatomic, strong)UIControl *bgMaskControl;///< 背景蒙层，加到delegate的window上
@property (nonatomic, strong)UIImageView *popoverArrowImgView;
@property (nonatomic, strong)UIView *popoverContentContainerView;

@property (nonatomic, assign)TMPopoverArrowDirection arrowDirection;///< 最终显示时，箭头视图的方向,

@end

@implementation TMPopoverView
TMUI_PropertyLazyLoad(UIControl, bgMaskControl);
TMUI_PropertyLazyLoad(UIImageView, popoverArrowImgView);
TMUI_PropertyLazyLoad(UIView, popoverContentContainerView);

+ (instancetype)popoverViewWithContentView:(UIView *)contentView contentSize:(CGSize)size {
    return [self popoverViewWithContentView:contentView layoutContentViewSize:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

+ (instancetype)popoverViewWithContentView:(UIView *)contentView layoutContentViewSize:(void(^_Nullable)(MASConstraintMaker *make))contentSizeMakeBlock {
    if (!contentView) {
        return nil;
    }
    
    TMPopoverView *popoverView = [[self alloc] init];
    [popoverView.popoverContentContainerView addSubview:contentView];
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (contentSizeMakeBlock) {
            contentSizeMakeBlock(make);
        }
        make.leading.top.mas_equalTo(4);
        make.trailing.bottom.mas_equalTo(-4);
    }];
    
    //将popoverView赋值给contentView的tmui_popoverView间接弱持有，方便外部通过子视图获取其所在的popoverView实例进行相关dimiss等操作
    contentView.tmui_popoverView = popoverView;
    
    return popoverView;
}

#pragma mark - dealloc log

TMUI_DEBUG_Code_Dealloc;

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubUIs];
    }
    return self;
}

- (void)initConfig {
    self.arrowSize = CGSizeMake(6, 4);
    _autoDismissWhenTouchOutSideContentView = YES;
    _maskBackgroundColor = [UIColor clearColor];
    _popoverBackgroundColor = UIColorHexString(@"353535");
    _popoverLayoutMargins = UIEdgeInsetsMake(tmui_safeAreaTopInset(), 10, tmui_safeAreaBottomInset(), 10);
}

- (void)loadSubUIs {
    [self initConfig];
    //蒙层视图是在显示时加到当前视图的superview上
    self.bgMaskControl.backgroundColor = self.maskBackgroundColor;
    [self.bgMaskControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.bgMaskControl.enabled = self.autoDismissWhenTouchOutSideContentView;
    //
    [self addSubview:self.popoverArrowImgView];
    [self addSubview:self.popoverContentContainerView];
    self.popoverContentContainerView.backgroundColor = self.popoverBackgroundColor;
    self.popoverContentContainerView.clipsToBounds = YES;
    self.popoverContentContainerView.layer.cornerRadius = 4;
    
    [self.popoverArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.mas_equalTo(-20);
        make.width.mas_equalTo([self fitArrowSize].width);
        make.height.mas_equalTo([self fitArrowSize].height);
    }];
    [self.popoverContentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset([self fitArrowSize].height);
        make.leading.mas_equalTo(self.mas_leading);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

#pragma mark - show methods
- (void)showFromBarButtonItem:(UIBarButtonItem *)barItem arrowDirection:(TMPopoverArrowDirection)arrowDirection {
    UIView *view = [self itemViewInItem:barItem];
    [self showFromRect:view.bounds inView:view arrowDirection:arrowDirection];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view arrowDirection:(TMPopoverArrowDirection)arrowDirection {
    if (!view) {
        return;
    }
    
    self.arrowDirection = arrowDirection;
    self.popoverContentContainerView.backgroundColor = self.popoverBackgroundColor;
    [self.popoverArrowImgView setImage:[self generateArrowImage]];
    
    UIView *superView = [UIApplication sharedApplication].delegate.window;
    [superView addSubview:self.bgMaskControl];
    [self.bgMaskControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.bgMaskControl.enabled = NO;
    self.bgMaskControl.alpha = 0;
    
    CGRect viewFrameToSuperView = [view convertRect:rect toView:superView];
    
    self.alpha = 0;
    [superView addSubview:self];
    
    float leftSafeGap = self.popoverLayoutMargins.left;
    float rightSafeGap = self.popoverLayoutMargins.right;
    float topSafeGap = self.popoverLayoutMargins.top;
    float bottomSafeGap = self.popoverLayoutMargins.bottom;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.arrowDirection == TMPopoverArrowDirectionUp) {
            make.top.mas_equalTo(superView.mas_top).mas_offset(CGRectGetMaxY(viewFrameToSuperView));
            make.bottom.mas_lessThanOrEqualTo(superView.mas_bottom).mas_offset(-bottomSafeGap);
            make.trailing.mas_lessThanOrEqualTo(-rightSafeGap);
            make.leading.mas_greaterThanOrEqualTo(leftSafeGap);
        }else if (self.arrowDirection == TMPopoverArrowDirectionDown) {
            make.bottom.mas_equalTo(superView.mas_top).mas_offset(CGRectGetMinY(viewFrameToSuperView));
            make.top.mas_greaterThanOrEqualTo(superView.mas_top).mas_offset(topSafeGap);
            make.trailing.mas_lessThanOrEqualTo(-rightSafeGap);
            make.leading.mas_greaterThanOrEqualTo(leftSafeGap);
        }else if (self.arrowDirection == TMPopoverArrowDirectionLeft) {
            make.leading.mas_equalTo(superView.mas_leading).mas_offset(CGRectGetMaxX(viewFrameToSuperView));
            make.trailing.mas_lessThanOrEqualTo(-rightSafeGap);
            make.top.mas_greaterThanOrEqualTo(superView.mas_top).mas_offset(topSafeGap);
            make.bottom.mas_lessThanOrEqualTo(superView.mas_bottom).mas_offset(-bottomSafeGap);
        }else if (self.arrowDirection == TMPopoverArrowDirectionRight) {
            make.trailing.mas_equalTo(superView.mas_leading).mas_offset(CGRectGetMinX(viewFrameToSuperView));
            make.leading.mas_greaterThanOrEqualTo(leftSafeGap);
            make.top.mas_greaterThanOrEqualTo(superView.mas_top).mas_offset(topSafeGap);
            make.bottom.mas_lessThanOrEqualTo(superView.mas_bottom).mas_offset(-bottomSafeGap);
        }
    }];
    
    float arrowLeftGap = 10;
    float arrowRightGap = 10;
    float arrowTopGap = 10;
    float arrowBottomGap = 10;
    [self.popoverArrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([self fitArrowSize]);
        if (self.arrowDirection == TMPopoverArrowDirectionUp) {
            make.top.mas_equalTo(0);
            make.leading.mas_greaterThanOrEqualTo(self.mas_leading).mas_offset(arrowLeftGap);
            make.trailing.mas_lessThanOrEqualTo(self.mas_trailing).mas_offset(-arrowRightGap);
            //关于箭头的x轴中心约束，指定其与点击的按钮视图中心位置居中对齐 \
            //再低优先级约束箭头视图的x轴中心尽量与内容视图的居中位置一致，当整体视图左右安全边距不满足箭头在内容视图的居中x轴位置显示时， \
            //优先保证安全边距的约束，故箭头与内容视图的x轴居中对齐的优先级设置为Low
            make.centerX.mas_equalTo(superView.mas_leading).mas_offset(CGRectGetMidX(viewFrameToSuperView));
            make.centerX.mas_equalTo(self.mas_centerX).mas_offset(self.arrowCenterOffset).priorityLow();
        }else if (self.arrowDirection == TMPopoverArrowDirectionDown) {
            make.bottom.mas_equalTo(0);
            make.leading.mas_greaterThanOrEqualTo(self.mas_leading).mas_offset(arrowLeftGap);
            make.trailing.mas_lessThanOrEqualTo(self.mas_trailing).mas_offset(-arrowRightGap);
            //关于箭头的x轴中心约束，指定其与点击的按钮视图中心位置居中对齐 \
            //再低优先级约束箭头视图的x轴中心尽量与内容视图的居中位置一致，当整体视图左右安全边距不满足箭头在内容视图的居中x轴位置显示时， \
            //优先保证安全边距的约束，故箭头与内容视图的x轴居中对齐的优先级设置为Low
            make.centerX.mas_equalTo(superView.mas_leading).mas_offset(CGRectGetMidX(viewFrameToSuperView));
            make.centerX.mas_equalTo(self.mas_centerX).mas_offset(self.arrowCenterOffset).priorityLow();
        }else if (self.arrowDirection == TMPopoverArrowDirectionLeft) {
            make.leading.mas_equalTo(0);
            make.top.mas_greaterThanOrEqualTo(self.mas_top).mas_offset(arrowTopGap);
            make.bottom.mas_lessThanOrEqualTo(self.mas_bottom).mas_offset(-arrowBottomGap);
            //关于箭头的y轴中心约束，指定其与点击的按钮视图中心位置居中对齐 \
            //再低优先级约束箭头视图的y轴中心尽量与内容视图的居中位置一致，当整体视图上下安全边距不满足箭头在内容视图的居中y轴位置显示时， \
            //优先保证安全边距的约束，故箭头与内容视图的y轴居中对齐的优先级设置为Low
            make.centerY.mas_equalTo(superView.mas_top).mas_offset(CGRectGetMidY(viewFrameToSuperView));
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(self.arrowCenterOffset).priorityLow();
        }else if (self.arrowDirection == TMPopoverArrowDirectionRight) {
            make.trailing.mas_equalTo(0);
            make.top.mas_greaterThanOrEqualTo(self.mas_top).mas_offset(arrowTopGap);
            make.bottom.mas_lessThanOrEqualTo(self.mas_bottom).mas_offset(-arrowBottomGap);
            //关于箭头的y轴中心约束，指定其与点击的按钮视图中心位置居中对齐 \
            //再低优先级约束箭头视图的y轴中心尽量与内容视图的居中位置一致，当整体视图上下安全边距不满足箭头在内容视图的居中y轴位置显示时， \
            //优先保证安全边距的约束，故箭头与内容视图的y轴居中对齐的优先级设置为Low
            make.centerY.mas_equalTo(superView.mas_top).mas_offset(CGRectGetMidY(viewFrameToSuperView));
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(self.arrowCenterOffset).priorityLow();
        }
    }];
    
    [self.popoverContentContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.arrowDirection == TMPopoverArrowDirectionUp) {
           make.top.mas_equalTo(self.mas_top).mas_offset([self fitArrowSize].height);
        }else if (self.arrowDirection == TMPopoverArrowDirectionDown) {
           make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-[self fitArrowSize].height);
        }else if (self.arrowDirection == TMPopoverArrowDirectionLeft) {
            make.leading.mas_equalTo(self.mas_leading).mas_offset([self fitArrowSize].width);
        }else if (self.arrowDirection == TMPopoverArrowDirectionRight) {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-[self fitArrowSize].width);
        }
    }];
    
    [self.superview setNeedsUpdateConstraints];
    [self.superview updateConstraints];
    [self.superview layoutIfNeeded];

#if DEBUG
    MASAttachKeys(self, self.popoverArrowImgView, self.popoverContentContainerView);
#endif
    
    //
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.bgMaskControl.alpha = 1;
    } completion:^(BOOL finished) {
        self.bgMaskControl.enabled = self.autoDismissWhenTouchOutSideContentView;
    }];
}

#pragma mark - hidsmiss methods
- (void)dismiss {
    [self dismissWithFinishBlock:nil];
}

- (void)dismissWithFinishBlock:(void(^_Nullable)(void))dismissFinishBlock {
    self.bgMaskControl.enabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.bgMaskControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgMaskControl removeFromSuperview];
        [self removeFromSuperview];
        if (dismissFinishBlock) {
            dismissFinishBlock();
        }
    }];
}

#pragma mark - private

- (void)setAutoDismissWhenTouchOutSideContentView:(BOOL)autoDismissWhenTouchOutSideContentView {
    _autoDismissWhenTouchOutSideContentView = autoDismissWhenTouchOutSideContentView;
    self.bgMaskControl.enabled = autoDismissWhenTouchOutSideContentView;
}

- (void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor {
    _maskBackgroundColor = maskBackgroundColor;
    if (_bgMaskControl) {
        _bgMaskControl.backgroundColor = maskBackgroundColor;
    }
}

- (void)setPopoverBackgroundColor:(UIColor *)popoverBackgroundColor {
    _popoverBackgroundColor = popoverBackgroundColor;
    _popoverContentContainerView.backgroundColor = popoverBackgroundColor;
    _popoverArrowImgView.image = [self generateArrowImage];
}

- (UIImage *)generateArrowImage {
    UIImage *arrowImg = [UIImage tmui_imageWithShape:TMUIImageShapeTriangle size:[self fitArrowSize] tintColor:self.popoverBackgroundColor];
    if (self.arrowDirection == TMPopoverArrowDirectionDown) {
        arrowImg = [arrowImg tmui_imageWithOrientation:UIImageOrientationDown];
    }else if (self.arrowDirection == TMPopoverArrowDirectionLeft) {
        arrowImg = [arrowImg tmui_imageWithOrientation:UIImageOrientationLeft];
    }else if (self.arrowDirection == TMPopoverArrowDirectionRight) {
        arrowImg = [arrowImg tmui_imageWithOrientation:UIImageOrientationRight];
    }
    return arrowImg;
}

- (CGSize)fitArrowSize {
    if (self.arrowDirection == TMPopoverArrowDirectionUp ||
        self.arrowDirection == TMPopoverArrowDirectionDown) {
        return self.arrowSize;
    }else {
        return CGSizeMake(self.arrowSize.height, self.arrowSize.width);
    }
}

#pragma mark - helps
/**返回item用于显示的视图对象，若取不到则返回nil*/
- (UIView *_Nullable)itemViewInItem:(UIBarButtonItem *)item {
    if (item.customView) {
        return item.customView;
    }
    NSArray<NSString *> *privateViewKeys = @[@"view", @"_view"];
    __block UIView *itemView = nil;
    [privateViewKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id view = [item valueForKey:obj];
        if (view && [view isKindOfClass:[UIView class]]) {
            itemView = view;
            *stop = YES;
        }
    }];
    return itemView;
}

@end


@implementation UIView(TMPopoverView)

- (void)setTmui_popoverView:(TMPopoverView *)tmui_popoverView {
    if (tmui_popoverView && ![tmui_popoverView isKindOfClass:[TMPopoverView class]]) {
TMUI_DEBUG_Code(
                NSLog(@"setTmui_popoverView: tmui_popoverView must be kind of TMPopoverView.class .");
                )
        return;
    }
    
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, @selector(tmui_popoverView));
    if (!weakObjContainer) {
        weakObjContainer = [TMUIWeakObjectContainer containerWithObject:tmui_popoverView];
    }
    weakObjContainer.object = tmui_popoverView;
    
    if (!tmui_popoverView) {
        weakObjContainer = nil;
    }
    objc_setAssociatedObject(self, @selector(tmui_popoverView), weakObjContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TMPopoverView *_Nullable)tmui_popoverView {
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, @selector(tmui_popoverView));
    if (weakObjContainer.object) {
        return weakObjContainer.object;
    }
    
    //若无缓存则向上逐级遍历找到父视图为TMPopoverView类型的数据并返回
    if (self.superview) {
        return self.superview.tmui_popoverView;
    }
    
    return nil;
}

@end
