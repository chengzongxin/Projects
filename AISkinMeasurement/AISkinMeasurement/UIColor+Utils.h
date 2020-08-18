//
//  UIColor+Utils.h
//  silu
//
//  Created by liman on 9/4/15.
//  Copyright (c) 2015年 upintech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString alpha:(CGFloat)alpha;

/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;

/**
 *  随机颜色
 */
+ (UIColor *)randomColor;

/**
*  随机颜色,根据Cell的index获取
*/
+ (UIColor *)randomColorTheme:(NSInteger)index;

@end
