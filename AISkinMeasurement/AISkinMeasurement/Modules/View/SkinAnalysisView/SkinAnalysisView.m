//
//  SkinAnalysisView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/22.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinAnalysisView.h"

@interface SkinAnalysisView ()

@property (strong, nonatomic) UIImageView *insideCircle;
@property (strong, nonatomic) UIImageView *middleCircle;
@property (strong, nonatomic) UIImageView *outsideCircle;
@property (strong, nonatomic) UIImageView *analysis;

@end

@implementation SkinAnalysisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.insideCircle];
    [self addSubview:self.middleCircle];
    [self addSubview:self.outsideCircle];
    [self addSubview:self.analysis];
    
    [self startAnimation];
}

- (UIImageView *)insideCircle{
    if (!_insideCircle) {
        _insideCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inside_circle"]];
        _insideCircle.center = self.center;
    }
    return _insideCircle;
}

- (UIImageView *)middleCircle{
    if (!_middleCircle) {
        _middleCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"middle_circle"]];
        _middleCircle.center = self.center;
    }
    return _middleCircle;
}

- (UIImageView *)outsideCircle{
    if (!_outsideCircle) {
        _outsideCircle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"outside_circle"]];
        _outsideCircle.center = self.center;
    }
    return _outsideCircle;
}

- (UIImageView *)analysis{
    if (!_analysis) {
        _analysis = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"analysising"]];
        _analysis.center = CGPointMake(self.center.x, self.center.y + 200);
    }
    return _analysis;
}

- (void)animation:(UIImageView *)imageView clockwise:(BOOL)clockwise{
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.fromValue = 0;
    animation.toValue = clockwise ? @(2 * M_PI) : @(2 * M_PI * -1);
    animation.duration = 5;
    animation.repeatCount = CGFLOAT_MAX;
    animation.keyPath = @"transform.rotation.z";
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)startAnimation{
    [self animation:self.insideCircle clockwise:YES];
    [self animation:self.middleCircle clockwise:NO];
    [self animation:self.outsideCircle clockwise:YES];
}

- (void)stopAnimation{
    [self.insideCircle.layer removeAllAnimations];
    [self.middleCircle.layer removeAllAnimations];
    [self.outsideCircle.layer removeAllAnimations];
}


@end
