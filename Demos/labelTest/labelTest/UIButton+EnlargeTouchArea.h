//
//  UIButton+EnlargeTouchArea.h
//  HouseKeeper
//  扩大按钮点击区域
//  Created by ben.gan on 2019/8/12.
//  Copyright © 2019 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeTouchArea)

- (void)t_setNormalTextColor:(UIColor *)color;
- (void)t_setUnEnableTextColor:(UIColor *)color;
- (UIColor *)t_normalTextColor;
- (UIColor *)t_unEnableTextColor;

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END


