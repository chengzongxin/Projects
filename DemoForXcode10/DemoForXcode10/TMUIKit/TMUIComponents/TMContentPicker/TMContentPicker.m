//
//  TMContentPicker.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMContentPicker.h"
#import "TMContentAlert.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"

#import <Masonry/Masonry.h>

@interface TMContentPicker()
@property (nonatomic, strong, readonly)UIControl *bgAlphaView;///< 背景全屏渐变视图
@property (nonatomic, strong, readonly)UIView *titleBarView;///< 标题栏视图，包含左侧取消按钮、右侧确定按钮、中间titlelbl
@property (nonatomic, strong, readonly)UILabel *titleLbl;///< 标题lbl
@property (nonatomic, strong, readonly)UIView *contentBoxView;///< 内容块视图，包含底部安全边距
@property (nonatomic, assign)CGSize selfSize;
@end

@implementation TMContentPicker
TMUI_PropertySyntheSize(bgAlphaView);
TMUI_PropertySyntheSize(titleBarView);
TMUI_PropertySyntheSize(titleLbl);
TMUI_PropertySyntheSize(contentBoxView);

TMUI_PropertyLazyLoad(UIControl, bgAlphaView);
TMUI_PropertyLazyLoad(UIView, titleBarView);
TMUI_PropertyLazyLoad(UILabel, titleLbl);
TMUI_PropertyLazyLoad(UIView, contentBoxView);


+ (instancetype)pickerView {
    __kindof TMContentPicker *picker = [[[self class] alloc] init];
    picker.autoDismissWhenTapBackground = YES;
    return picker;
}

- (void)setAutoDismissWhenTapBackground:(BOOL)autoDismissWhenTapBackground {
    _autoDismissWhenTapBackground = autoDismissWhenTapBackground;
    self.bgAlphaView.enabled = autoDismissWhenTapBackground;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLbl.text = title;
}

- (void)setContentView:(UIView *)contentView {
    if (_contentView && [_contentView.superview isEqual:self.contentBoxView]) {
        NSAssert(0, @"已有内容视图显示后不能再次修改当前显示的内容视图");
        return;
    }
    _contentView = contentView;
    //
    if (_contentView && _contentBoxView) {
        [self _loadContentViewIfNeed];
    }
}

- (void)showFromViewController:(UIViewController *)fromVc {
    
    @TMUI_weakify(self);
    [TMContentAlert showFromViewController:fromVc loadContentView:^(__kindof UIViewController * _Nonnull toShowVc) {
        @TMUI_strongify(self);
        self.bgAlphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [toShowVc.view addSubview:self.bgAlphaView];
        self.bgAlphaView.frame = toShowVc.view.bounds;
        [self.bgAlphaView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        CGRect startRect = CGRectMake(0, toShowVc.view.bounds.size.height, toShowVc.view.bounds.size.width, 34 + self.contentView.bounds.size.height + tmui_safeAreaBottomInset());
        [toShowVc.view addSubview:self];
        self.frame = startRect;
        self.selfSize = startRect.size;
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(startRect.size.height);
            make.bottom.mas_equalTo(toShowVc.view.mas_bottom).mas_offset(startRect.size.height);
        }];
        self.bgAlphaView.alpha = 0;
        self.alpha = 0.6;
        if (self.willShowBlock) {
            self.willShowBlock();
        }
    } didShowBlock:^{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bgAlphaView.alpha = 1;
            self.alpha = 1;
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo((self.tmui_viewController.view.mas_bottom));
            }];
            
            [self.superview setNeedsUpdateConstraints];
            [self.superview updateConstraintsIfNeeded];
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (self.didShowBlock) {
                self.didShowBlock();
            }
        }];
    }];
}

- (void)dismiss {
    [self dismissWithFinishBlock:nil];
}

#pragma mark -
- (void)confirmBtnClick {
    [self dismissWithFinishBlock:self.confirmEventBlockAfterDismiss];
}

- (void)dismissWithFinishBlock:(void(^_Nullable)(void))finishBlock {
    if (self.willDismissBlock) {
        self.willDismissBlock();
    }
    
    @TMUI_weakify(self);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgAlphaView.alpha = 0;
        self.alpha = 0.6;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.tmui_viewController.view.mas_bottom).mas_offset(self.selfSize.height);
        }];
        
        [self.superview setNeedsUpdateConstraints];
        [self.superview updateConstraintsIfNeeded];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [TMContentAlert hiddenContentView:self didHiddenBlock:^{
            @TMUI_strongify(self);
            if (self.didDismissBlock) {
                self.didDismissBlock();
            }
            //
            if (finishBlock) {
                finishBlock();
            }
        }];
    }];
}

#pragma mark -
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [self setupSubviews];
        [self _loadContentViewIfNeed];
    }
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor tmui_colorWithHexString:@"EFEFF4"];
    
    self.titleBarView.clipsToBounds = YES;
    self.contentBoxView.clipsToBounds = YES;
    
    [self addSubview:self.titleBarView];
    [self addSubview:self.contentBoxView];
    
    [self.titleBarView addSubview:self.titleLbl];
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBarView addSubview:cancelBtn];
    UIButton *okBtn = [[UIButton alloc] init];
    [okBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.titleBarView addSubview:okBtn];
    
    [self.bgAlphaView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    
    //config
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl.font = UIFont(15);
    self.titleLbl.textColor = [UIColor tmui_colorWithHexString:@"999999"];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [cancelBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [okBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [okBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [@[cancelBtn, okBtn] enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setTitleColor:[UIColor tmui_colorWithHexString:@"007AFF"] forState:UIControlStateNormal];
        [btn setTitleColor:[[UIColor tmui_colorWithHexString:@"007AFF"] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:UIFont(15)];
    }];
    
    //layout
    [self.titleBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(34);
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.titleLbl.mas_centerY);
    }];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.titleLbl.mas_centerY);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(cancelBtn.mas_trailing);
        make.trailing.mas_equalTo(okBtn.mas_leading);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.self.titleBarView.mas_centerY).mas_offset(4);
    }];
    //
    [self.contentBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.titleBarView.mas_bottom);
    }];
}

- (void)_loadContentViewIfNeed {
    if (self.contentView && !
        [self.contentView.superview isEqual:self.contentBoxView]) {
        CGSize size = self.contentView.bounds.size;
        [self.contentBoxView addSubview:self.contentView];
        self.contentView.backgroundColor = [UIColor clearColor];        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.centerY.mas_equalTo(self.contentBoxView.mas_centerY).mas_offset(0 - tmui_safeAreaBottomInset()/2);
            make.height.mas_equalTo(size.height);
        }];
    }
}

@end
