//
//  TMSearchPresentationAnimatedTransition.m
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/7.
//  Copyright © 2020 t8t. All rights reserved.
//

#import "TMSearchPresentationAnimatedTransition.h"
#import "TMSearchController.h"

@interface TMSearchPresentationAnimatedTransition()
@property (nonatomic, strong)UIColor *searchBarOriginBackgroundColor;
@property (nonatomic, strong)UIColor *searchBarTextFieldBackgroundColor;
@property (nonatomic, weak)TMSearchBar *searchBar;
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UIView *searchBarOriginSuperView;
@property (nonatomic, assign)CGRect searchBarOriginFrameInOriginSuperView;

@property (nonatomic, assign)BOOL isNavigationBarHiddenBeforePresent;
@end

@implementation TMSearchPresentationAnimatedTransition

+ (instancetype)transitionWithTransitionType:(TMSearchPresentationAnimatedTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TMSearchPresentationAnimatedTransitionType)type {
    if (self = [self init]) {
        self.currentType = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.currentType == TMSearchPresentationAnimatedTransitionTypePresent) {
        [self presentAnimateTransition:transitionContext];
    }else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    self.isNavigationBarHiddenBeforePresent = fromVc.navigationController.isNavigationBarHidden;
    
    TMSearchController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert([toVc isKindOfClass:[TMSearchController class]], @"toVc should be TMSearchController instance");
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = toVc.searchBar;
    self.searchBarOriginBackgroundColor = toVc.searchBar.backgroundColor;
    self.searchBarTextFieldBackgroundColor = toVc.searchBar.textField.backgroundColor;
    
    CGRect fromRect = [self.searchBar convertRect:self.searchBar.bounds toView:containerView];
    
    if ([self.searchBar.superview isKindOfClass:[UITableView class]] &&
        [self.searchBar isEqual:[(UITableView*)self.searchBar.superview tableHeaderView]]) {
        self.tableView = (UITableView *)self.searchBar.superview;
        self.searchBarOriginFrameInOriginSuperView = [self.searchBar convertRect:self.searchBar.bounds toView:fromVc.view];
        UIView *positionHeaderView = [[UIView alloc] initWithFrame:self.searchBar.bounds];
        self.tableView.tableHeaderView = positionHeaderView;
    }else {
        self.searchBarOriginFrameInOriginSuperView = self.searchBar.frame;
        self.searchBarOriginSuperView = self.searchBar.superview;
    }
    
    toVc.view.backgroundColor = [UIColor whiteColor];
    toVc.contentView.alpha = 0;
    toVc.searchBarContainerView.alpha = 0;
    toVc.view.alpha = 1;
    [containerView addSubview:toVc.view];
    [toVc.view setFrame:containerView.bounds];
    
    CGRect toRect = toVc.searchBarContainerView.frame;
    toRect.origin.y = toRect.size.height - 44;
    toRect.size.height = 44;
    CGRect endRectInBar = toRect;
            
    [containerView addSubview:self.searchBar];
    self.searchBar.frame = fromRect;
                    
    if (!self.isNavigationBarHiddenBeforePresent) {
        [fromVc.navigationController setNavigationBarHidden:YES animated:YES];
    }
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.searchBar.frame = toRect;
        self.searchBar.backgroundColor = [UIColor whiteColor];
        self.searchBar.textField.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:236.0f/255.0f alpha:1];
        toVc.contentView.alpha = 1;
        toVc.searchBarContainerView.alpha = 1;
        
        [containerView setNeedsLayout];
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [toVc.searchBarContainerView addSubview:self.searchBar];
        self.searchBar.frame = endRectInBar;
        
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    TMSearchController *fromVc = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert([fromVc isKindOfClass:[TMSearchController class]], @"fromVc should be TMSearchController instance");
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor whiteColor];
            
    CGRect fromRect = [self.searchBar convertRect:self.searchBar.bounds toView:containerView];
    
    CGRect endRect = self.searchBarOriginFrameInOriginSuperView;
    CGRect toRect = [toVc.view convertRect:endRect toView:containerView];
    float restoreNavHeight = 0;
    if (!self.isNavigationBarHiddenBeforePresent) {
        restoreNavHeight = fromVc.searchBarContainerView.bounds.size.height;
    }
    toRect.origin.y += restoreNavHeight;
    [containerView addSubview:self.searchBar];
    
    self.searchBar.frame = fromRect;
        
    if (!self.isNavigationBarHiddenBeforePresent) {
        [toVc.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.searchBar.frame = toRect;
        self.searchBar.backgroundColor = self.searchBarOriginBackgroundColor;
        self.searchBar.textField.backgroundColor = self.searchBarTextFieldBackgroundColor;

        fromVc.view.alpha = 0;
        
        [containerView setNeedsLayout];
        [containerView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (self.tableView) {
            self.tableView.tableHeaderView = self.searchBar;
        }else {
            [toVc.view addSubview:self.searchBar];
            self.searchBar.frame = endRect;
        }

        [transitionContext completeTransition:YES];
    }];
}

@end
