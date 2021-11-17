//
//  UIView+TMUI.h
//  TMUIKitDemo
//
//  Created by nigel.ning on 2020/4/14.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TMUI)

/**
 获取当前视图显示时对应的的viewController
 @note 若当前视图vc承载进行展示则返回nil
 @note 只读方法，不支持kvo
 */
@property (nonatomic, readonly, nullable)UIViewController *tmui_viewController;

/**返回view展示时对应承载的viewController*/
+ (UIViewController *_Nullable)tmui_viewControllerOfView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
