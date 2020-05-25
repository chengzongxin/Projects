//
//  UIView+Convenient.h
//  MU
//
//  Created by Joe on 2020/2/21.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Convenient)

@property (assign, nonatomic) CGFloat   top;
@property (assign, nonatomic) CGFloat   bottom;
@property (assign, nonatomic) CGFloat   left;
@property (assign, nonatomic) CGFloat   right;

@property (assign, nonatomic) CGFloat   x;
@property (assign, nonatomic) CGFloat   y;
@property (assign, nonatomic) CGPoint   origin;

@property (assign, nonatomic) CGFloat   centerX;
@property (assign, nonatomic) CGFloat   centerY;

@property (assign, nonatomic) CGFloat   width;
@property (assign, nonatomic) CGFloat   height;
@property (assign, nonatomic) CGSize    size;


#pragma mark - xib
+ (instancetype)viewFromXib;

#pragma mark - 半圆角
/**
 设置半圆View
 
 @param direct 半圆的方向
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 
 @param radius 半圆半径,传0就默认高度一般(半圆)
 */
- (void)halfCircleCornerDirect:(UIRectCorner)direct radius:(int)radius;

/**
 设置View全部u圆角
 @param radius 半圆半径,传0就默认高度一般(半圆)
 */
- (void)halfAllCircleCornerWithRadius:(int)radius;

#pragma mark - 边框
/**
 设置View边框和颜色
 
 @param color 颜色
 @param width 宽度
 @param radius 圆角
 */
- (void)setBorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius;


- (void)addBorder:(UIColor *)color width:(CGFloat)width type:(UIRectEdge)rect;

#pragma mark - 背景，渐变，阴影
/// 快捷设置阴影，圆角，渐变（frame 适用居中显示的情况）
- (void)setShadowGradient;

/// 设置阴影，圆角，渐变
- (void)setShadowColor:(UIColor *)shadowColor
           shadowOffet:(CGSize)shadowOffset
         shadowOpacity:(float)shadowOpacity
          shadowRadius:(CGFloat)shadowRadius
        gradientColors:(NSArray <UIColor *> *)gradientColors
         gradientFrame:(CGRect)gradientFrame
            startPoint:(CGPoint)startPoint
              endPoint:(CGPoint)endPoint
        gradientCorner:(CGFloat)gradientCorner
             locations:(NSArray<NSNumber *>*)locations;

/// 设置阴影
- (void)setShadowColor:(UIColor *)shadowColor
           shadowOffet:(CGSize)shadowOffset
         shadowOpacity:(float)shadowOpacity
          shadowRadius:(CGFloat)shadowRadius;

// 设置渐变圆角背景
- (void)setGradientColors:(NSArray <UIColor *> *)gradientColors
            gradientFrame:(CGRect)gradientFrame
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint
           gradientCorner:(CGFloat)gradientCorner
                locations:(NSArray<NSNumber *>*)locations;


#pragma mark - UIView 生成 UIImage
//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertToImage;

@end

NS_ASSUME_NONNULL_END
