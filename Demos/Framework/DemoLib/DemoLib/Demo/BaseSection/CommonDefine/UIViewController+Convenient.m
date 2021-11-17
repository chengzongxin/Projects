//
//  UIViewController+Convenient.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import "UIViewController+Convenient.h"

@implementation UIViewController (Convenient)
#pragma mark -  获取当前最顶层的ViewController
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    result = [self topVC:result];
    while(result.presentedViewController) {
        result = [self topVC:result.presentedViewController];
    }
    return result;
}

+ (UIViewController*)topVC:(UIViewController*)VC {
    if([VC isKindOfClass:[UINavigationController class]]) {
        return [self topVC:[(UINavigationController*)VC topViewController]];
    }
    if([VC isKindOfClass:[UITabBarController class]]) {
        return [self topVC:[(UITabBarController*)VC selectedViewController]];
    }
    return VC;
}
@end
