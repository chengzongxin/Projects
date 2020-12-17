//
//  CALayer+Shadow.m
//  Matafy
//
//  Created by Jason on 2018/4/23.
//  Copyright © 2018年 com.upintech. All rights reserved.
//

#import "CALayer+Shadow.h"

@implementation CALayer (Shadow)

- (void)applyShadow:(UIColor *)color alpha:(float)alpha x:(CGFloat)x y:(CGFloat)y blue:(CGFloat)blur spread:(CGFloat)spread{
    self.shadowColor = color.CGColor;
    self.shadowOpacity = alpha;
    self.shadowOffset = CGSizeMake(x, y);
    self.shadowRadius = blur / 2.0;
    if (spread == 0){
        self.shadowPath = nil;
    } else {
        CGFloat dx = -spread;
        CGRect rect = CGRectInset(self.bounds, dx, dx);
        self.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    }
}




@end
