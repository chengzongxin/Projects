//
//  PageCollectionView.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageCollectionView.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"

@implementation PageCollectionView


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
            // tag = 1不滑动
            bgScrollView.tag = 1;
            
        }else{
            // tag = 0 默认滑动
            bgScrollView.tag = 0;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //    NSLog(@"%s",__FUNCTION__);
    //    if (otherGestureRecognizer.view.tag == 888) { // contentScrollView 不滑动
    //        return NO;
    //    }
    if ([otherGestureRecognizer.view isKindOfClass:PageScrollView.class]) {
        return YES;
    }
    
    //    NSLog(@"%@",otherGestureRecognizer.view);
    return NO;
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
