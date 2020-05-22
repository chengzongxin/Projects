//
//  UIImage+Convenient.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/22.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Convenient)
/**
*  生成图片
*
*  @return 颜色
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  圆形图片
 *
 *  @return 圆形图片
 */
- (UIImage *)circleImage;
@end

NS_ASSUME_NONNULL_END
