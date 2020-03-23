//
//  UIView+Frame.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 状态栏高度 */
#define kStatusH UIApplication.sharedApplication.statusBarFrame.size.height
/* 导航条高度 */
#define kNavbarH ((self.navigationController.navigationBar && !self.navigationController.navigationBarHidden)? 44 : 0)
/* 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width
/* 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property CGFloat width;
@property CGFloat height;
@property CGFloat x;
@property CGFloat y;
@property CGFloat centerX;
@property CGFloat centerY;

+ (instancetype)viewFromXib;

@end

NS_ASSUME_NONNULL_END
