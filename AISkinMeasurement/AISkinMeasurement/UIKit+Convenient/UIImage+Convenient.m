//
//  UIImage+Convenient.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/22.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "UIImage+Convenient.h"

@implementation UIImage (Convenient)

/**
*  生成图片
*
*  @return 颜色
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  圆形图片
 *
 *  @return 圆形图片
 */
- (UIImage *)circleImage{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef imgRef = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(imgRef, rect);
    CGContextClip(imgRef);
    [self drawInRect:rect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
