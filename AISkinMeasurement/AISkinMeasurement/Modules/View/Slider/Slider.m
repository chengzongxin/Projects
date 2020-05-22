//
//  Slider.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/22.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "Slider.h"
#import "UIKitConvenient.h"

@implementation Slider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *circleImg = [[UIImage imageWithColor:UIColor.whiteColor size:CGSizeMake(12, 12)] circleImage];
        [self setThumbImage:circleImg forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)trackRectForBounds:(CGRect)bounds{
    bounds = [super trackRectForBounds:bounds];//必须通过调用父类的trackRectForBounds 获取一个 bounds 值，否则 Autolayout 会失效，UISlider 的位置会跑偏。
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,4);//这里面的20即为你想要设置的高度。
}

@end
