//
//  TMActionSheet.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/23.
//

#import "TMActionSheet.h"
#import "TMContentAlert.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"
#import <Masonry/Masonry.h>

@interface TMActionSheetAction()
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic, assign) TMActionSheetActionStyle style;
@property (nonatomic, copy, nullable)void (^handler)(TMActionSheetAction *action);
@end

@implementation TMActionSheetAction
+ (instancetype)actionWithTitle:(NSString *)title style:(TMActionSheetActionStyle)style handler:(void (^)(TMActionSheetAction * _Nonnull))handler {
    TMActionSheetAction *action = [[[self class] alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

@end

@interface TMActionSheetContentView: UIView
@property (nonatomic, strong, readonly)TMActionSheet *actionSheet;
+ (instancetype)actionSheetViewWithActionSheet:(TMActionSheet *)actionSheet;
- (void)show;
- (void)updateUI;
@end

@interface TMActionSheet()
@property (nonatomic, copy, nullable)NSString *title;
@property (nonatomic, weak)UIViewController *fromVc;
@property (nonatomic, strong, nullable)TMActionSheetAction *cancelAction;
@property (nonatomic, strong)NSMutableArray<TMActionSheetAction *> *actions;
@property (nonatomic, weak)TMActionSheetContentView *view;
@end

@implementation TMActionSheet

+ (instancetype)showWithTitle:(NSString *)title
                      actions:(NSArray<TMActionSheetAction *> *)actions
           fromViewController:(UIViewController *)fromVc {
    TMActionSheet *actionSheet = [[[self class] alloc] init];
    actionSheet.title = title;
    actionSheet.actions = [NSMutableArray array];
    [actionSheet.actions addObjectsFromArray:actions];
    actionSheet.fromVc = fromVc;
    
    [actions enumerateObjectsUsingBlock:^(TMActionSheetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.style == TMActionSheetActionStyleCancel) {
            actionSheet.cancelAction = obj;
            *stop = YES;
        }
    }];
    if (actionSheet.cancelAction) {
        [actionSheet.actions removeObject:actionSheet.cancelAction];
    }
    [actionSheet assertMoreThanOneCacelStyle];
    //
    TMActionSheetContentView *view = [TMActionSheetContentView actionSheetViewWithActionSheet:actionSheet];
    actionSheet.view = view;
    [view show];
    
    return actionSheet;
}

- (void)addActions:(NSArray<TMActionSheetAction *> *)actions {
    if (actions.count == 0) {return;}
    
    if (!self.cancelAction) {
        [actions enumerateObjectsUsingBlock:^(TMActionSheetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.style == TMActionSheetActionStyleCancel) {
                self.cancelAction = obj;
                *stop = YES;
            }
        }];
        
        if (self.cancelAction) {
            [self.actions addObjectsFromArray:actions];
            [self.actions removeObject:self.cancelAction];
        }
    }else {
        [self.actions addObjectsFromArray:actions];
    }
    
    [self assertMoreThanOneCacelStyle];
    //更新UI显示
    [self.view updateUI];
}

- (void)assertMoreThanOneCacelStyle {
    __block NSInteger cancelStyleItemCount = 0;
    if (self.cancelAction) {
        cancelStyleItemCount = 1;
    }
    [self.actions enumerateObjectsUsingBlock:^(TMActionSheetAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.style == TMActionSheetActionStyleCancel) {
            cancelStyleItemCount++;
        }
    }];
    if (cancelStyleItemCount > 1) {
        NSAssert(cancelStyleItemCount <= 1, @"TMActionSheet can not have more than on cancel-style buttons");
        [[NSException exceptionWithName:@"TMActionSheetError" reason:@"TMActionSheet can not have more than on cancel-style buttons" userInfo:nil] raise];
    }
}

@end

@interface TMActionSheetContentView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)TMActionSheet *actionSheet;
@property (nonatomic, strong)UIView *bgPlaceHolderView;///< 占位视图，用于辅助判断当前vc的显示方向
@property (nonatomic, strong)UIControl *contentBgView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIView *titleAndListBackgroundView;
@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong)UILabel *titleLbl;
@property (nonatomic, strong)UIView *sepLine;
@property (nonatomic, strong)UITableView *actionListView;
@property (nonatomic, strong, nullable)UIButton *cancelButton;
@end

@implementation TMActionSheetContentView

TMUI_PropertyLazyLoad(UIView, bgPlaceHolderView);
TMUI_PropertyLazyLoad(UIControl, contentBgView);
TMUI_PropertyLazyLoad(UIView, contentView);
TMUI_PropertyLazyLoad(UIView, titleAndListBackgroundView);
TMUI_PropertyLazyLoad(UIView, titleView);
TMUI_PropertyLazyLoad(UILabel, titleLbl);
TMUI_PropertyLazyLoad(UIView, sepLine);
TMUI_PropertyLazyLoad(UITableView, actionListView);
TMUI_PropertyLazyLoad(UIButton, cancelButton);

+ (instancetype)actionSheetViewWithActionSheet:(TMActionSheet *)actionSheet {
    TMActionSheetContentView *view = [[[self class] alloc] init];
    view.actionSheet = actionSheet;
    return view;
}

- (void)show {
    @TMUI_weakify(self);
    [TMContentAlert showFromViewController:self.actionSheet.fromVc loadContentView:^(__kindof UIViewController * _Nonnull toShowVc) {
        @TMUI_strongify(self);
        toShowVc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [toShowVc.view addSubview:self];
        CGRect rt = toShowVc.view.bounds;
        self.frame = rt;
        [self updateUI];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self.contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rt.size.height);
            make.height.mas_equalTo(rt.size.height);
        }];
        //
        toShowVc.view.alpha = 0;
    } didShowBlock:^{
        @TMUI_strongify(self);
        [UIView animateWithDuration:0.25 animations:^{
            self.tmui_viewController.view.alpha = 1;
            [self.contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
            }];
            [self.contentBgView.superview setNeedsUpdateConstraints];
            [self.contentBgView.superview updateConstraintsIfNeeded];
            [self.contentBgView.superview layoutSubviews];
        }];
    }];
}

- (void)dismiss {
    @TMUI_weakify(self);
    [self dismissWithFinishBlock:^{
        @TMUI_strongify(self);
        if (self.actionSheet.cancelAction.handler) {
            self.actionSheet.cancelAction.handler(self.actionSheet.cancelAction);
        }
    }];
}

- (void)dismissWithFinishBlock:(void(^_Nullable)(void))finishBlock {
    CGFloat offset = self.contentView.bounds.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.tmui_viewController.view.alpha = 0;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentBgView.mas_bottom).mas_offset(offset);
        }];
        [self.contentView.superview setNeedsUpdateConstraints];
        [self.contentView.superview updateConstraintsIfNeeded];
        [self.contentView.superview layoutSubviews];
        
    } completion:^(BOOL finished) {
       [TMContentAlert hiddenContentView:self didHiddenBlock:finishBlock];
    }];
}

#pragma mark - update UI
- (void)updateUI {
    CGSize size = self.tmui_viewController.view.bounds.size;
    [self.contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    
    if (size.width > size.height) {
        [self updateContentShowForLandscape];
    }else {
        [self updateContentShowForPortraint];
    }
}

- (void)updateContentShowForPortraint {
    CGFloat topSafe = tmui_safeAreaTopInset() + 44;
    CGFloat bottomSafe = tmui_safeAreaBottomInset();
    [self updateContentHeightWithTopSafe:topSafe bottomSafe:bottomSafe];
}

- (void)updateContentShowForLandscape {
    CGFloat topSafe = tmui_safeAreaTopInset() + 20;
    CGFloat bottomSafe = tmui_safeAreaBottomInset();
    [self updateContentHeightWithTopSafe:topSafe bottomSafe:bottomSafe];
}

- (void)updateContentHeightWithTopSafe:(CGFloat)topSafe bottomSafe:(CGFloat)bottomSafe {
    CGSize size = [UIApplication sharedApplication].delegate.window.bounds.size;
    CGFloat titleViewHeight = self.actionSheet.title.length > 0 ? 45 : 0;
    CGFloat actionsListHeight = self.actionSheet.actions.count * 56;
    CGFloat cancelBtnHeight = self.actionSheet.cancelAction ? 56 : 0;
    CGFloat middleGap = (titleViewHeight + actionsListHeight > 0 && cancelBtnHeight > 0) ? 8 : 0;
    
    actionsListHeight = MIN(actionsListHeight, size.height - topSafe - bottomSafe - middleGap - cancelBtnHeight - titleViewHeight);
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomSafe + middleGap + cancelBtnHeight + actionsListHeight + titleViewHeight);
    }];
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleViewHeight);
    }];
    self.titleLbl.text = self.actionSheet.title;
    [self.actionListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(actionsListHeight);
    }];
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(bottomSafe > 0 ? -bottomSafe : 0);
    }];
    self.cancelButton.hidden = cancelBtnHeight > 0 ? NO : YES;
    if (self.actionSheet.cancelAction) {
        [self.cancelButton setTitle:self.actionSheet.cancelAction.title forState:UIControlStateNormal];
    }
    
    self.sepLine.hidden = (titleViewHeight > 0 && actionsListHeight > 0) ? NO : YES;
    self.actionListView.scrollEnabled = actionsListHeight < self.actionSheet.actions.count * 56;
    [self.actionListView reloadData];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
    [self layoutIfNeeded];
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgPlaceHolderView];
        self.bgPlaceHolderView.userInteractionEnabled = NO;
        [self.bgPlaceHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
                
        [self.contentBgView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.contentBgView];
        [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(frame.size.height);
            make.top.mas_equalTo(0);
        }];
        
        [self.contentBgView addSubview:self.contentView];
        self.contentView.clipsToBounds = YES;
        CGSize size = [UIScreen mainScreen].bounds.size;
        float minWidth = MIN(size.width, size.height);
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(minWidth - 8*2);
            make.centerX.mas_equalTo(self.contentBgView.mas_centerX);
            make.bottom.mas_equalTo(self.contentBgView.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        //加载cancelBtn, 默认隐藏
        [self.contentView addSubview:self.cancelButton];
        self.cancelButton.hidden = YES;
        self.cancelButton.clipsToBounds = YES;
        self.cancelButton.layer.cornerRadius = 14;
        [self.cancelButton setTitleColor:[UIColor tmui_colorWithHexString:@"007AFF"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = UIFontSemibold(20);
        [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton setBackgroundImage:[UIImage tmui_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[UIImage tmui_imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.75]] forState:UIControlStateHighlighted];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.height.mas_equalTo(56);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-tmui_safeAreaBottomInset());
        }];
        
        //
        [self.contentView addSubview:self.titleAndListBackgroundView];
        self.titleAndListBackgroundView.backgroundColor = [UIColor whiteColor];
        self.titleAndListBackgroundView.clipsToBounds = YES;
        self.titleAndListBackgroundView.layer.cornerRadius = 14;
        [self.titleAndListBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.trailing.mas_equalTo(0);
        }];
        
        //加载上部分titleView
        [self.titleAndListBackgroundView addSubview:self.titleView];
        self.titleView.clipsToBounds = YES;
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
        
        [self.titleView addSubview:self.titleLbl];
        self.titleLbl.font = UIFontSemibold(13);
        self.titleLbl.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.titleLbl.textAlignment = NSTextAlignmentCenter;
        [self.titleView addSubview:self.titleLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(8);
            make.trailing.mas_equalTo(-8);
            make.centerY.mas_equalTo(self.titleView.mas_centerY);
        }];
                        
        self.sepLine.clipsToBounds = YES;
        self.sepLine.backgroundColor = [UIColor lightGrayColor];
        [self.titleView addSubview:self.sepLine];
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        self.sepLine.hidden = YES;
        
        //加载上部分列表
        [self.actionListView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kCell"];
        [self.titleAndListBackgroundView addSubview:self.actionListView];
        self.actionListView.delegate = self;
        self.actionListView.dataSource = self;
        self.actionListView.separatorInset = UIEdgeInsetsZero;
        self.actionListView.separatorColor = [UIColor lightGrayColor];
        [self.actionListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.top.mas_equalTo(self.titleView.mas_bottom);
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self.titleAndListBackgroundView.mas_bottom);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    BOOL isFirstShow = NO;
    CGSize oldSize = self.bgPlaceHolderView.bounds.size;
    if (CGSizeEqualToSize(CGSizeZero, oldSize)) {
        isFirstShow = YES;
    }
    [super layoutSubviews];
    if (isFirstShow) {
        return;
    }

    CGSize size = self.bounds.size;
    [self.contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    //
    if (CGSizeEqualToSize(oldSize, size)) {return;}
        
    if (size.width > size.height) {
        //切换到横屏，调整内容视图的高度约束
        [self updateContentShowForLandscape];
    }else {
        //切换到竖屏，调整内容视图的高度约束
        [self updateContentShowForPortraint];
    }
}

#pragma mark - tableview delegate & datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionSheet.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCell"];
    UILabel *lbl = [cell.contentView viewWithTag:1001];
    if (!lbl) {
        lbl = [[UILabel alloc] init];
        lbl.tag = 1001;
        [cell.contentView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    [self configLabel:lbl withActionStyle:self.actionSheet.actions[indexPath.row].style];
    lbl.text = self.actionSheet.actions[indexPath.row].title;
    
    return cell;
}

- (void)configLabel:(UILabel *)lbl withActionStyle:(TMActionSheetActionStyle)actionStyle {
    lbl.font = UIFontRegular(20);
    if (actionStyle == TMActionSheetActionStyleDefault) {
        lbl.textColor = [UIColor tmui_colorWithHexString:@"007AFF"];
    }else if (actionStyle == TMActionSheetActionStyleDestructivem) {
        lbl.textColor = [UIColor tmui_colorWithHexString:@"FF3B30"];
    }else if (actionStyle == TMActionSheetActionStyleGray) {
        lbl.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TMActionSheetAction *action = self.actionSheet.actions[indexPath.row];
    [self dismissWithFinishBlock:^{
        if (action.handler) {
            action.handler(action);
        }
    }];
}

@end
