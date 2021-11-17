//
//  TMEmptyView.m
//  Masonry
//
//  Created by nigel.ning on 2020/6/29.
//

#import "TMEmptyView.h"
#import "TMEmptyContentItem.h"
#import <Masonry/Masonry.h>
#import "TMUICore.h"
#import "UIColor+TMUI.h"
#import "TMUIWeakObjectContainer.h"
#import <objc/runtime.h>
#import "UIView+TMUI.h"

@interface TMEmptyView()
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UIView *contentBoxView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *descLbl;

@property (nonatomic, strong)NSObject<TMEmptyContentItemProtocol> *contentItem;

@property (nonatomic, strong)UIButton *navBackBtn;
@property (nonatomic, assign)BOOL canShowNavBackBtn;///< 是否应该显示额外的返回按钮，默认为NO，仅在有系统nav且系统导航条隐藏的情况下需要调整为YES，其它情况都为NO
@property (nonatomic, assign)BOOL hasSetShowNavBackBtnFlag;///< 若外部手动调用了setShowNavBackBtn则标记为YES

@end

@implementation TMEmptyView

TMUI_DEBUG_Code_Dealloc;

/**margin缺省为UIEdgeInsetsZero，点击block缺省为nil*/
+ (instancetype)showEmptyInView:(UIView *)view
                    contentType:(TMEmptyContentType)contentType {
    return [self showEmptyInView:view contentType:contentType clickBlock:nil];
}

/**margin缺省为UIEdgeInsetsZero*/
+ (instancetype)showEmptyInView:(UIView *)view
                    contentType:(TMEmptyContentType)contentType
                     clickBlock:(void(^_Nullable)(void))block {
    return [self showEmptyInView:view safeMargin:UIEdgeInsetsZero contentType:contentType clickBlock:block];
}

+ (instancetype)showEmptyInView:(UIView *)view
                     safeMargin:(UIEdgeInsets)margin
                    contentType:(TMEmptyContentType)contentType
                     clickBlock:(void(^_Nullable)(void))block {
    return [self showEmptyInView:view safeMargin:margin contentType:contentType configContentBlock:nil clickBlock:block];
}

+ (instancetype)showEmptyInView:(UIView *)view
                     safeMargin:(UIEdgeInsets)margin
                    contentType:(TMEmptyContentType)contentType
             configContentBlock:(void(^_Nullable)(NSObject<TMEmptyContentItemProtocol> *content))configContentBlock
                     clickBlock:(void(^_Nullable)(void))block {
    TMEmptyContentItem *item = [TMEmptyContentItem itemWithEmptyType:contentType];
    item.clickEmptyBlock = block;
    if (configContentBlock) {
        configContentBlock(item);
    }
    return [self showEmptyInView:view safeMargin:margin withContentItem:item];
}


+ (instancetype)showEmptyInView:(UIView *)view
                     safeMargin:(UIEdgeInsets)margin
                withContentItem:(NSObject<TMEmptyContentItemProtocol> *)contentItem {
    if (!view) {
TMUI_DEBUG_Code(
                NSLog(@"empty must not be show in view: nil");
                )
        return nil;
    }
    
    if (!contentItem) {
TMUI_DEBUG_Code(
                NSLog(@"empty must not be show with contentItem: nil");
                )
        return nil;
    }
    
    if (!contentItem.emptyImg &&
        contentItem.title.length == 0 &&
        contentItem.desc.length == 0) {
TMUI_DEBUG_Code(
                NSLog(@"empty contentItem is invalid. img: %@, title: %@, desc: %@", contentItem.emptyImg ? @"OK" : @"nil", contentItem.title.length > 0 ? contentItem.title : @"nil", contentItem.desc.length > 0 ? contentItem.desc : @"nil");
                )
        return nil;
    }
    
    //先移除旧的空态视图UI
    if (view.tmui_emptyView) {
        [view.tmui_emptyView removeFromSuperview];
        view.tmui_emptyView = nil;
    }
    
    CGRect rt = view.bounds;
    rt.origin.x = margin.left;
    rt.origin.y = margin.top;
    rt.size.width = rt.size.width - margin.left - margin.right;
    rt.size.height = rt.size.height - margin.top - margin.bottom;
    TMEmptyView *emptyV = [[TMEmptyView alloc] initWithFrame:rt];
    [emptyV updateUiWithContentItem:contentItem];
    view.tmui_emptyView = emptyV;
    emptyV.backgroundColor = contentItem.emptyBackgroundColor ?: [UIColor whiteColor];
    [view addSubview:emptyV];
    if ([view isKindOfClass:[UIScrollView class]]) {
//父视图指定为scrollview类型，约束需要特殊处理
//因部分页可能在viewDidAppear响应之前就调用了showEmpty，此时取到的view.bounds为初始值并非最终显示的实际尺寸，故此处考虑还是用约束来指定空态视图的位置尺寸
        [emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_top).mas_offset(margin.top);
            make.leading.mas_equalTo(view.mas_leading).mas_offset(margin.left);
            make.trailing.mas_equalTo(view.mas_trailing).mas_offset(-margin.right);
            make.bottom.mas_equalTo(view.mas_bottom).mas_offset(-margin.bottom);
            //必须额外指定显示位置居中才能保持显示效果正常\ 因可能外部有自定义左右、上下边距，这里还需要单独处理，以下赋值逻辑是否正确还有待后续的UI多场景的实际效果
            make.centerX.mas_equalTo(view.mas_centerX).mas_offset((margin.left - margin.right) * 0.5);
            make.centerY.mas_equalTo(view.mas_centerY).mas_offset((margin.top - margin.bottom) * 0.5);
        }];
        
    }else {
        [emptyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_top).mas_offset(margin.top);
            make.leading.mas_equalTo(view.mas_leading).mas_offset(margin.left);
            make.trailing.mas_equalTo(view.mas_trailing).mas_offset(-margin.right);
            make.bottom.mas_equalTo(view.mas_bottom).mas_offset(-margin.bottom);
        }];
    }
    
    //赋值指定的合适的返回icon
    if (contentItem.navBackIcon) {
        [emptyV.navBackBtn setImage:contentItem.navBackIcon forState:UIControlStateNormal];
    }
    return emptyV;
}

- (void)remove {
    [self removeFromSuperview];
}

- (void)setShowNavBackBtn:(BOOL)showNavBackBtn {
    _showNavBackBtn = showNavBackBtn;
    self.hasSetShowNavBackBtnFlag = YES;
    if (self.canShowNavBackBtn) {
        self.navBackBtn.hidden = !showNavBackBtn;
    }
}

- (void)navBackBtnClick {
    if (self.navBackBtnCustomClickBlock) {
        self.navBackBtnCustomClickBlock();
    }else {
        UINavigationController *nav = [self __navVc];
        if (nav) {
            [[self __navVc] popViewControllerAnimated:YES];
        }else {
            NSAssert(NO, @"操作错误，当前emptyview无法向上追溯到navigationController实例");
        }
    }
}

- (UINavigationController *)__navVc {
    UIViewController *vc = self.tmui_viewController;
    UINavigationController *nav = nil;
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController*)vc;
    }else {
        nav = vc.navigationController;
    }
    
    if (!nav) {
        UIViewController *parentVc = vc.parentViewController;
        while (parentVc) {
            if ([parentVc isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)parentVc;
            }else if (parentVc.navigationController) {
                nav = parentVc.navigationController;
            }
            
            if (nav) {
                break;
            }
            
            parentVc = parentVc.parentViewController;
        }
    }
    
    return nav;
}

#pragma mark - update ui
- (void)updateUiWithContentItem:(NSObject<TMEmptyContentItemProtocol> *)contentItem {
    self.contentItem = contentItem;
    
    [self.contentBoxView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(contentItem.contentCenterOffsetY);
    }];
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(contentItem.emptyImgSize.width);
        make.height.mas_equalTo(contentItem.emptyImgSize.height);
    }];
    [self.titleLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(contentItem.distanceBetweenImgBottomAndTitleTop > 0 ? contentItem.distanceBetweenImgBottomAndTitleTop : 24);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
    [self layoutIfNeeded];
    
    self.imgView.image = contentItem.emptyImg;
    if (contentItem.attributedTitle.length > 0) {
        self.titleLbl.attributedText = contentItem.attributedTitle;
    }else {
        self.titleLbl.text = contentItem.title;
    }
    if (contentItem.attributedDesc.length > 0) {
        self.descLbl.attributedText = contentItem.attributedDesc;
    }else {
        self.descLbl.text = contentItem.desc.length > 0 ? contentItem.desc : nil;
    }    
}

#pragma mark - private

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self loadSubUI];
    }
    return self;
}


TMUI_PropertyLazyLoad(UIButton, bgButton);
TMUI_PropertyLazyLoad(UIView, contentBoxView);
TMUI_PropertyLazyLoad(UIImageView, imgView);
TMUI_PropertyLazyLoad(UILabel, titleLbl);
TMUI_PropertyLazyLoad(UILabel, descLbl);

- (void)loadSubUI {
    self.clipsToBounds = YES;
    [self.bgButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    self.contentBoxView.userInteractionEnabled = NO;
    
    self.imgView.clipsToBounds = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.bgButton];
    [self addSubview:self.contentBoxView];
    [self.contentBoxView addSubview:self.imgView];
    [self.contentBoxView addSubview:self.titleLbl];
    [self.contentBoxView addSubview:self.descLbl];
    
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.contentBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentBoxView.mas_top);
        make.centerX.mas_equalTo(self.contentBoxView.mas_centerX);
        make.width.height.mas_equalTo(0);
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(24);
        make.leading.mas_equalTo(self.contentBoxView.mas_leading).mas_offset(20);
        make.trailing.mas_equalTo(self.contentBoxView.mas_trailing).mas_offset(-20);
    }];
    
    [self.descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLbl.mas_bottom).mas_offset(8);
        make.leading.mas_equalTo(self.titleLbl.mas_leading);
        make.trailing.mas_equalTo(self.titleLbl.mas_trailing);
        make.bottom.mas_equalTo(self.contentBoxView.mas_bottom);
    }];
    
    //
    self.titleLbl.numberOfLines = 2;
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl.font = UIFontSemibold(14);
    self.titleLbl.textColor = UIColorHexString(@"111111");
    
    self.descLbl.numberOfLines = 3;
    self.descLbl.textAlignment = NSTextAlignmentCenter;
    self.descLbl.font = UIFontRegular(14);
    self.descLbl.textColor = UIColorHexString(@"AAAFBE");
    
    //迭代追加带nav但navBar隐藏时全屏空态页下，左上角增加返回按钮
    self.navBackBtn = [[UIButton alloc] init];
    [self.navBackBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navBackBtn.hidden = YES;//默认为隐藏
    [self.navBackBtn setImage:[TMEmptyContentItem emptyNavBackIconByType:TMEmptyContentTypeNoData] forState:UIControlStateNormal];//指定默认的返回icon为黑色
    [self addSubview:self.navBackBtn];
    [self.navBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.height.mas_equalTo(44);
        make.top.mas_equalTo(MAX(20, tmui_safeAreaTopInset()));
    }];
    //
#if DEBUG
    MASAttachKeys(self.bgButton, self.imgView, self.titleLbl, self.descLbl, self.contentBoxView, self.navBackBtn);
#endif
}

- (void)clickAction {
    self.bgButton.enabled = NO;
    if (self.contentItem.clickEmptyBlock) {
        self.contentItem.clickEmptyBlock();
    }
    self.bgButton.enabled = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {
        BOOL showNavBtn = NO;
        if(self.superview.frame.origin.x == 0.0 && self.superview.frame.origin.y == 0.0 &&
           CGSizeEqualToSize(self.bounds.size, [UIScreen mainScreen].bounds.size)) {
            [self updateNavBackBtnCanShowIfNeed];
            if (self.canShowNavBackBtn) {
                if (!self.hasSetShowNavBackBtnFlag) {
                    self.showNavBackBtn = YES;
                    showNavBtn = YES;
                    return;
                }else {
                    showNavBtn = self.showNavBackBtn;
                }
            }
        }
        
        self.navBackBtn.hidden = !showNavBtn;
    }
}

- (void)updateNavBackBtnCanShowIfNeed {
    UINavigationController *nav = [self __navVc];
    if (nav && nav.isNavigationBarHidden && nav.viewControllers.count > 1) {
        self.canShowNavBackBtn = YES;
    }else {
        self.canShowNavBackBtn = NO;
    }
}

@end




@implementation UIView(TMEmptyView)

- (void)setTmui_emptyView:(TMEmptyView *)tmui_emptyView {
    if (tmui_emptyView && ![tmui_emptyView isKindOfClass:[TMEmptyView class]]) {
TMUI_DEBUG_Code(
                NSLog(@"setTmui_emptyView: setTmui_emptyView must be kind of TMEmptyView.class .");
                )
        return;
    }
    
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, @selector(tmui_emptyView));
    if (!weakObjContainer) {
        weakObjContainer = [TMUIWeakObjectContainer containerWithObject:tmui_emptyView];
    }
    weakObjContainer.object = tmui_emptyView;
    
    if (!tmui_emptyView) {
        weakObjContainer = nil;
    }
    objc_setAssociatedObject(self, @selector(tmui_emptyView), weakObjContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TMEmptyView *_Nullable)tmui_emptyView {
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, @selector(tmui_emptyView));
    if (weakObjContainer.object) {
        return weakObjContainer.object;
    }
    
    return nil;
}

@end
