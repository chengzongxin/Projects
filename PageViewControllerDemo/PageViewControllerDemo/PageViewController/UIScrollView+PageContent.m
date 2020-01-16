//
//  UIScrollView+PageContent.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/16.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "UIScrollView+PageContent.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"

@implementation UIScrollView (PageContent)


#pragma mark - Private
// 通知监听滚动
- (void)didScroll{
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    PageScrollView *bgScrollView = (PageScrollView *)self.superview.superview.superview;
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

//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    PageScrollView *bgScrollView = (PageScrollView *)scrollView.superview.superview.superview;
    if ([bgScrollView isKindOfClass:UIScrollView.class]) {
        UIViewController *currentVC = [self currentViewController];
        CGFloat navH = ((currentVC.navigationController.navigationBar && !currentVC.navigationController.navigationBarHidden)? 44 : 0);
        if (bgScrollView.contentOffset.y < (bgScrollView.headerView.height - navH - kStatusH)) {
            scrollView.contentOffset = CGPointZero;
        }
        
        if (scrollView.contentOffset.y <= 0) {
            scrollView.contentOffset = CGPointZero;
            bgScrollView.fixed = NO;
        }else{
            bgScrollView.fixed = YES;
        }
    }
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
