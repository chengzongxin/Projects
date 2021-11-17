//
//  UIViewController+Convenient.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Convenient)
#pragma mark -  获取当前最顶层的ViewController
+ (UIViewController *)getCurrentVC;
@end

NS_ASSUME_NONNULL_END
