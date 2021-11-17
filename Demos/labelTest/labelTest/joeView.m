//
//  joeView.m
//  labelTest
//
//  Created by Joe.cheng on 2021/3/17.
//

#import "joeView.h"

@implementation joeView

- (void)dealloc{
    NSLog(@"%@ did dealloc",self);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
