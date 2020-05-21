//
//  CALayer+Convenient.h
//  MU
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Convenient)

// xib快速设置

// xib 设置边框颜色
- (void)setBorderColorWithUIColor:(UIColor *)color;
// xib 设置边框颜色
- (void)setBorderColorE:(UIColor *)color;
// xib 设置边框颜色
- (void)setBorderWidthE:(CGFloat)width;
// xib 设置圆角
-(void)setCorner:(CGFloat)cornerRadius;
@end

NS_ASSUME_NONNULL_END
