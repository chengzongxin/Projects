//
//  CALayer+Convenient.m
//  MU
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import "CALayer+Convenient.h"

@implementation CALayer (Convenient)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

- (void)setBorderColorE:(UIColor *)color{
    self.borderColor = color.CGColor;
}

- (void)setBorderWidthE:(CGFloat)width{
    self.borderWidth = width;
}

-(void)setCorner:(CGFloat)cornerRadius{
    self.masksToBounds = YES;
    self.cornerRadius = cornerRadius;
}
@end
