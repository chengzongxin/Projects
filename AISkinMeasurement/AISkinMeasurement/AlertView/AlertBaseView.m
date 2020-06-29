//
//  AlertBaseView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "AlertBaseView.h"

static NSString *const AnimationKeyShow = @"AnimationKeyShow";
static NSString *const AnimationKeyDismiss = @"AnimationKeyDismiss";

@interface AlertBaseView ()

//@property (strong, nonatomic) UIView *customView;

@end

@implementation AlertBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = UIScreen.mainScreen.bounds;
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
//        self.customView = [self prepareSubviews];
//        [self setupAlertView];
//        self.delegate = self;
    }
    return self;
}

//- (UIView *)prepareSubviews{return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];}
// 注意这里会把xib初始化的自己加到initWithFrame初始化的自己身上
//- (void)setupAlertView{
//    self.customView.center = self.center;
//    [self addSubview:self.customView];
//}

- (instancetype)initWithXib:(Class)className{
    self = [super init];
    if (self) {
        self.frame = UIScreen.mainScreen.bounds;
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
        self.customView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(className) owner:nil options:nil] firstObject];
    }
    return self;
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    customView.center = self.center;
}

- (void)show {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
    [self addSubview:self.customView];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = 0.4;
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@0, @0.5, @1];
    opacityAnimation.keyTimes = scaleAnimation.keyTimes;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.4;
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards; // 动画结束后停留在最终位置
    
    [self.customView.layer addAnimation:animationGroup forKey:AnimationKeyShow];
}

- (void)dismiss {
    self.backgroundColor = UIColor.clearColor;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.4;

    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.2)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)]];
    scaleAnimation.keyTimes = @[@0.0, @0.32, @1.0];

    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.values = @[@1, @1, @0];
    opacityAnimation.keyTimes = scaleAnimation.keyTimes;


    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards; // 动画结束后停留在最终位置
    [self.customView.layer addAnimation:animationGroup forKey:AnimationKeyDismiss];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.customView.layer animationForKey:AnimationKeyShow] == anim) {
        // 显示动画x结束
//        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
    }else if ([self.customView.layer animationForKey:AnimationKeyDismiss] == anim) {
        // 消失动画结束
        self.opaque = 0;
        self.frame = CGRectZero;
        [self removeFromSuperview];
    }
}

@end
