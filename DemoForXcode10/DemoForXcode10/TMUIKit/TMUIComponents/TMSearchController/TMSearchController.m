//
//  TMSearchController.m
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/6.
//  Copyright © 2020 t8t. All rights reserved.
//

#import "TMSearchController.h"
#import "TMSearchPresentationAnimatedTransition.h"
#import <Masonry/Masonry.h>
#import "TMUICore.h"

@interface TMSearchController ()<TMSearchBarDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong)UIView *searchingContainerView;///< 用于承载searchingController.view视图的显示
@property (nonatomic, strong, nullable)UIViewController<TMSearchingControllerProtocol> *searchingController;

@property (nonatomic, strong)TMSearchBar *searchBar;

@property (nonatomic, weak)UIViewController *searchBarSuperViewOriginController;

@property (nonatomic, strong)TMSearchPresentationAnimatedTransition *presentTransition;

@end

@implementation TMSearchController
@synthesize searchBarContainerView = _searchBarContainerView;
@synthesize contentView = _contentView;

TMUI_DEBUG_Code_Dealloc;

- (instancetype)initWithSearchingController:(UIViewController<TMSearchingControllerProtocol> *)searchingController {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.searchBar.delegate = self;
        self.searchingController = searchingController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;
    
    float statusBarHeight = 20;
    if (@available(iOS 11, *)) {
        statusBarHeight = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
    }
    _searchBarContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, statusBarHeight + 44)];
    self.searchBarContainerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBarContainerView];
    [self.searchBarContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(statusBarHeight + 44);
    }];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBarContainerView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.searchBarContainerView.frame))];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.searchBarContainerView.mas_bottom);
    }];
    
    self.searchingContainerView = [[UIView alloc] initWithFrame:_contentView.frame];
    self.searchingContainerView.clipsToBounds = YES;
    [self.view addSubview:self.searchingContainerView];
    self.searchingContainerView.hidden = YES;
    
    if (self.searchingController) {
        [self addChildViewController:self.searchingController];
        [self.searchingContainerView addSubview:self.searchingController.view];
        [self.searchingController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
}

- (TMSearchBar *)searchBar {
    if(!_searchBar) {
        _searchBar = [[TMSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _searchBar.clipsToBounds = YES;
    }
    return _searchBar;
}

- (UIViewController *)searchBarSuperViewOriginController {
    if (!_searchBarSuperViewOriginController) {
        if (_searchBar && _searchBar.superview) {
            UIResponder *nextResp = [_searchBar nextResponder];
            do {
                if ([nextResp isKindOfClass:[UIViewController class]]) {
                    break;
                }
                nextResp = [nextResp nextResponder];
            }while (nextResp);
            if ([nextResp isKindOfClass:[UIViewController class]]) {
                _searchBarSuperViewOriginController = (UIViewController *)nextResp;
            }
        }
    }
    return _searchBarSuperViewOriginController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self.searchBar isFirstResponder]) {
        [self.searchBar becomeFirstResponder];
    }
}

#pragma mark - active change
@synthesize active = _active;
- (BOOL)isActive {
    return _active;
}

- (void)setActive:(BOOL)active animate:(BOOL)animate {
    _active = active;
    [self.searchBar setActive:active animate:animate];
    
    if (active) {
        if (self.presentingViewController) {
            [self updateSubPageViewShowStatuesAfterSearchTextChanged];
            return;
        }
                    
        //do custom present
        self.transitioningDelegate = self;
        self.searchBarSuperViewOriginController.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//经过测试，设置为此值。对应represent后，self.presentingViewController才是调用present的vc对象，且在searchVc不消失的状态下，只要取到当前app中的nav作push操作，即可以达到正常的效果
        @TMUI_weakify(self);
        [self callbackPageEventIfNeed:TMSearchControllerPageEventWillPresent];
        [self.searchBarSuperViewOriginController presentViewController:self animated:YES completion:^{
            @TMUI_strongify(self);
            [self callbackPageEventIfNeed:TMSearchControllerPageEventDidPresent];
            [self.searchBar becomeFirstResponder];
        }];
        
    }else {
        
        self.searchBar.text = nil;
        
        if (!self.presentingViewController) {
            return;
        }
                        
        //dismiss
        @TMUI_weakify(self);
        [self callbackPageEventIfNeed:TMSearchControllerPageEventWillDismiss];
        [self dismissViewControllerAnimated:YES completion:^{
            @TMUI_strongify(self);
            [self callbackPageEventIfNeed:TMSearchControllerPageEventDidDismiss];
        }];
        
    }
}

- (void)callbackPageEventIfNeed:(TMSearchControllerPageEvent)pEvent {
    TMUI_DEBUG_Code(
                    NSLog(@"pageEvent: %@ => %@", @(pEvent), self);
                    )
    if (self.pageEventCallBack) {
        self.pageEventCallBack(pEvent, self);
    }
}

#pragma mark - TMSearchBarDelegate
- (void)updateSubPageViewShowStatuesAfterSearchTextChanged {
    if (self.searchBar.isActive) {
        if (self.searchBar.text.length > 0) {
            self.searchingContainerView.hidden = NO;
            self.contentView.hidden = YES;
        }else {
            self.searchingContainerView.hidden = YES;
            self.contentView.hidden = NO;
        }
        [self.searchingController fuzzySearchForText:[self currentSearchBarText]];
    }
}
- (void)tmSearchBarTextDidBeginEditing:(TMSearchBar *)searchBar {
    [self searchBarSuperViewOriginController];
    [self setActive:YES animate:YES];
}

- (NSString *)currentSearchBarText {
    return [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)tmSearchBar:(TMSearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateSubPageViewShowStatuesAfterSearchTextChanged];
}

- (void)tmSearchBarSearchButtonClicked:(TMSearchBar *)searchBar {
    if (searchBar.isActive) {
        [self.searchingController clickSearchWithText:[self currentSearchBarText]];
    }
}

- (void)tmSearchBarCancelButtonClicked:(TMSearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self setActive:NO animate:YES];
}

#pragma mark - present transition delegate | UIViewControllerTransitioningDelegate

- (TMSearchPresentationAnimatedTransition *)presentTransition {
    if (!_presentTransition) {
        _presentTransition = [TMSearchPresentationAnimatedTransition transitionWithTransitionType:TMSearchPresentationAnimatedTransitionTypePresent];
    }
    return _presentTransition;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presentTransition.currentType = TMSearchPresentationAnimatedTransitionTypePresent;
    return self.presentTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presentTransition.currentType = TMSearchPresentationAnimatedTransitionTypeDismiss;
    return self.presentTransition;
}

//只有当 self.modalPresentationStyle = UIModalPresentationCustom 时 才会触发以下方法，可通过继承后自定义的UIPresentationController对象才处理一些额外的自定义UI及管理相关动画交互等处理逻辑
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    return nil;
//}

@end
