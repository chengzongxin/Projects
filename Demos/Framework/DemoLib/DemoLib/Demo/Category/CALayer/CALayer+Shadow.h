//
//  CALayer+Shadow.h
//  Matafy
//
//  Created by Jason on 2018/4/23.
//  Copyright © 2018年 com.upintech. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Shadow)

/**
 设置阴影,投影范围
 //    _bgView.layer.cornerRadius   = 8;//设置imageView的圆角
 //
 //    //    _bgView.layer.masksToBounds = YES;  // 设置这一句阴影无效
 //
 //    _bgView.layer.shadowColor    = [UIColor colorWithHexString:@"0x85868B"].CGColor;//设置阴影的颜色
 //
 //    _bgView.layer.shadowOpacity  = 0.33;//设置阴影的透明度
 //
 //    _bgView.layer.shadowOffset   = CGSizeMake(0, 0);//设置阴影的偏移量
 //
 //    _bgView.layer.shadowRadius   = 2;//设置阴影的圆角
 
 */


/**
 设置阴影,投影范围

 @param color 阴影颜色
 @param alpha 阴影透明度
 @param x x偏移
 @param y y偏移
 @param blur 模糊
 @param spread 延伸
 */
- (void)applyShadow:(UIColor *)color alpha:(float)alpha x:(CGFloat)x y:(CGFloat)y blue:(CGFloat)blur spread:(CGFloat)spread;

@end
