//
//  UIImage+THKCorner.h
//  THKCorner
//
//  Created by amby on 2020/05/16.
//  Copyright © 2020 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THKCornerModel.h"

@interface UIImage (THKCorner)

/**
 Add corner to a UIImage instance.
 给一个UIImage对象添加圆角
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 */
- (UIImage *)imageByAddingCornerRadius:(THKRectRadius)radius;

/**
 Create a UIImage by UIColor.
 通过颜色创建图片，大小为 1 x 1
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Create a UIImage with corner by UIColor.
 通过颜色创建带圆角的图片
 @param color The color of the image.
 图片的颜色
 @param size The size of the image.
 图片的尺寸
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(THKRectRadius)radius;

/**
 Create a UIImage with the contents of a layer.
 将layer的内容渲染为图片
 @param layer Whose contents will be rendered in the image.
 将要被渲染到图片的layer
 @param radius The radiuses of 4 corners. If you pass THKRectRadiusZero, the final image will not add corner
 4个圆角的半径，如果传入THKRectRadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)imageWithLayer:(CALayer *)layer cornerRadius:(THKRectRadius)radius;

/**
 Create a UIImage with gradual changing color.
 创建一个渐变色的图片
 @param graColor gradual changing color properties.
 渐变色的属性
 @param size The size of the image.
 图片的尺寸
 @param radius The radiuses of 4 corners. If you pass THKRectRadiusZero, the final image will not add corner
 4个圆角的半径，如果传入THKRectRadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)imageWithGradualChangingColor:(void(^)(THKGradualChangingColor *graColor))handler size:(CGSize)size cornerRadius:(THKRectRadius)radius;

/**
 Create a UIImage with border and corner. Always uses in UIButton
 创建一个边框图片，可以带圆角。通常在UIButton使用
 @param corner The properities of corner, see THKCorner.
 corner的属性，看THKCorner的介绍
 @param size The size of the image.
 图片的尺寸
 */
+ (UIImage *)imageWithTHKCorner:(void(^)(THKCorner *corner))handler size:(CGSize)size;

@end
