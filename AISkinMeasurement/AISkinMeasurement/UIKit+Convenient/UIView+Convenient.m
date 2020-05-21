//
//  UIView+Convenient.m
//  MU
//
//  Created by Joe on 2020/2/21.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import "UIView+Convenient.h"

@implementation UIView (Convenient)

#pragma mark - xib
+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

#pragma mark - 半圆角
// 半圆角
- (void)halfCircleCornerDirect:(UIRectCorner)direct radius:(int)radius {
    [self layoutIfNeeded];
    
    // 传0就默认高度一般(半圆)
    radius = radius?radius:self.bounds.size.height / 2;
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:direct cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
    self.layer.masksToBounds = YES;
}

- (void)halfAllCircleCornerWithRadius:(int)radius {
    [self halfCircleCornerDirect:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight radius:radius];
}

#pragma mark - 边框
- (void)setBorderForColor:(UIColor *)color
                    width:(float)width
                   radius:(float)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}


#pragma mark - 背景，渐变，阴影

- (void)setShadowGradient{
    // xib生成的view宽度不准确
    UIWindow *window= [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self convertRect:self.bounds toView:window];
    // 重新计算frame
    CGRect frame = self.bounds;
    frame.size.width = UIScreen.mainScreen.bounds.size.width - rect.origin.x*2;
    
    [self setShadowColor:[UIColor colorWithRed:0/255.0 green:123/255.0 blue:255/255.0 alpha:0.37]
             shadowOffet:CGSizeMake(0, 5)
           shadowOpacity:1
            shadowRadius:15
          gradientColors:@[UIColor.redColor,UIColor.blueColor]
           gradientFrame:frame
              startPoint:CGPointMake(0, 0)
                endPoint:CGPointMake(1, 0)
          gradientCorner:4
               locations:@[@0.0,@1.0]];
}

- (void)setShadowColor:(UIColor *)shadowColor
           shadowOffet:(CGSize)shadowOffset
         shadowOpacity:(float)shadowOpacity
          shadowRadius:(CGFloat)shadowRadius
        gradientColors:(NSArray <UIColor *> *)gradientColors
         gradientFrame:(CGRect)gradientFrame
            startPoint:(CGPoint)startPoint
              endPoint:(CGPoint)endPoint
        gradientCorner:(CGFloat)gradientCorner
             locations:(NSArray<NSNumber *>*)locations {
    [self setShadowColor:shadowColor shadowOffet:shadowOffset shadowOpacity:shadowOpacity shadowRadius:shadowRadius];
    [self setGradientColors:gradientColors gradientFrame:gradientFrame startPoint:startPoint endPoint:endPoint gradientCorner:gradientCorner locations:locations];
}


- (void)setShadowColor:(UIColor *)shadowColor
           shadowOffet:(CGSize)shadowOffset
         shadowOpacity:(float)shadowOpacity
          shadowRadius:(CGFloat)shadowRadius{
    //        _bgView.layer.masksToBounds = YES;  // 设置这一句阴影无效
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}


- (void)setGradientColors:(NSArray <UIColor *> *)gradientColors
            gradientFrame:(CGRect)gradientFrame
               startPoint:(CGPoint)startPoint
                 endPoint:(CGPoint)endPoint
           gradientCorner:(CGFloat)gradientCorner
                locations:(NSArray<NSNumber *>*)locations {
    //渐变色，圆角
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)gradientColors.firstObject.CGColor,(__bridge id)gradientColors.lastObject.CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = locations;
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = gradientFrame;
    // 设置渐变背景圆角，view本身不设置圆角
    gradientLayer.cornerRadius = gradientCorner;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    if ([self.layer.sublayers.firstObject isKindOfClass:CAGradientLayer.class]) {
        // 防止重复添加
        [self.layer.sublayers.firstObject removeFromSuperlayer];
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

#pragma mark - UIView 生成 UIImage
//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)convertToImage {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

@end
