//
//  UIScrollView+PageContent.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/16.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "UIScrollView+PageContentScrollView.h"
#import "PageBGScrollView.h"
#import "UIView+Frame.h"
#import "PageConst.h"

@implementation UIScrollView (PageContentScrollView)


- (void)bindNotificationWithSuperview:(UIView *)newSuperview{
    // 旧的父控件移除监听-重新添加或者视图消失会移除
    if (self.observationInfo) {
        [self removeObservers];
    }
    
    if (newSuperview) { // 新的父控件
        // 添加监听
        [self addObservers];
    }
}


#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;// | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:PageKeyPathContentOffset options:options context:nil];
    [self addObserver:self forKeyPath:PageKeyPathContentSize options:options context:nil];
}

- (void)removeObservers
{
    [self removeObserver:self forKeyPath:PageKeyPathContentOffset];
    [self removeObserver:self forKeyPath:PageKeyPathContentSize];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:PageKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:PageKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [self didScroll];
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self didScroll];
}

#pragma mark - Private
// 通知监听滚动
- (void)didScroll{
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    PageBGScrollView *bgScrollView = [self getPageScrollView];
    if ([bgScrollView isKindOfClass:UIScrollView.class]) {
        UIViewController *currentVC = [self currentViewController];
        CGFloat navH = ((currentVC.navigationController.navigationBar && !currentVC.navigationController.navigationBarHidden)? 44 : 0);
        if (bgScrollView.contentOffset.y < (bgScrollView.headerView.height - navH - kStatusH)) {
            //            self.contentOffset = CGPointZero; // 递归,死循环
            CGRect bounds = self.bounds;
            bounds.origin = CGPointZero;
            self.bounds = bounds;
        }
        
        if (self.contentOffset.y <= 0) {
            //            self.contentOffset = CGPointZero;  // 递归,死循环
            CGRect bounds = self.bounds;
            bounds.origin = CGPointZero;
            self.bounds = bounds;
            
            bgScrollView.fixed = NO;
        }else{
            bgScrollView.fixed = YES;
        }
    }
}

/**
 遍历superview 获取PageScrollView
 */
- (PageBGScrollView *)getPageScrollView{
    UIView *superview = self.superview;
    while (superview) {
        if ([superview isKindOfClass:PageBGScrollView.class]) {
            break;
        }else{
            superview = superview.superview;
            
            if (superview == nil) {
                return nil;
            }
        }
    }
    
    return (PageBGScrollView *)superview;
}

/**
 获取当前显示的控制区
 */
- (UIViewController*)currentViewController; {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}
@end
