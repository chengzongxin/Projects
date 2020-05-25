//
//  MenuPopView.m
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import "AlertView.h"
#import "UIKitConvenient.h"

#define kAlertW 294
#define kAlertH 148
#define kAlertShortH 148

@interface AlertView () <CAAnimationDelegate>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

@end


@implementation AlertView

- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
                      confirm:(NSString *)confirm
                       cancel:(NSString *)cancel{
    self = [super init];
    if(self) {
        _title = title;
        _subtitle = subtitle;
        [self setupSubViews];
        _titleLabel.text = title;
        _subtitleLabel.text = subtitle;
        [_confirm setTitle:confirm forState:UIControlStateNormal];
        [_cancel setTitle:cancel forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      confirm:(NSString *)confirm
                       cancel:(NSString *)cancel{
    self = [super init];
    if(self) {
        _title = title;
        [self setupSubViews];
        _container.height = kAlertShortH;
        _titleLabel.text = title;
        [_subtitleLabel removeFromSuperview];
        [_confirm setTitle:confirm forState:UIControlStateNormal];
        [_cancel setTitle:cancel forState:UIControlStateNormal];
        _titleLabel.y = 42;
        _confirm.y = 72;
        _cancel.y = 72;
    }
    return self;
}


- (void)setupSubViews{
    self.frame = UIScreen.mainScreen.bounds;
//    self.backgroundColor = COLOR(0, 0, 0, 0.5);
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)]];
    
    // 判断subtitle几行
    CGFloat padding = 24;
    CGFloat rowHeight = 20;
    CGFloat textWidth = [_subtitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
//    CGFloat textWidth = [_subtitle singleLineSizeWithText:[UIFont fontWithName:@"PingFangSC-Regular" size:14]].width;
    
    int additionRows = textWidth / (kAlertW - padding*2);
    CGFloat additionHeight = additionRows * rowHeight;
    
    // container
    _container = [[UIView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width-kAlertW)/2.0, 244, kAlertW, kAlertH + additionHeight)];
    _container.backgroundColor = UIColor.whiteColor;
    _container.layer.cornerRadius = 12;
    _container.layer.masksToBounds = YES;
    [self addSubview:_container];
    // title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, kAlertW, 25)];
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 18];
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_container addSubview:_titleLabel];
    // subtitle
    _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 58, kAlertW - padding * 2, 22 + additionHeight)];
    _subtitleLabel.numberOfLines = 0;
    _subtitleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _subtitleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [_container addSubview:_subtitleLabel];
    // confirm
    _confirm = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_container.bounds) - 48, kAlertW/2.0, 48)];
    [_confirm setTitleColor:HEXCOLOR(0x00C3CE) forState:UIControlStateNormal];
    _confirm.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    _confirm.layer.cornerRadius = 14;
    _confirm.backgroundColor = UIColor.whiteColor;
    [_container addSubview:_confirm];
    [_confirm setBorderForColor:HEXCOLOR(0xEEEEEE) width:1 radius:0];
    [_confirm addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    _confirm.tag = 1;
    // cancel
    _cancel = [[UIButton alloc] initWithFrame:CGRectMake(kAlertW/2.0, CGRectGetMaxY(_container.bounds) - 48, kAlertW/2.0, 48)];
    [_cancel setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    _cancel.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 16];
    _cancel.layer.cornerRadius = 14;
    _cancel.backgroundColor = UIColor.whiteColor;
    [_container addSubview:_cancel];
    [_cancel setBorderForColor:HEXCOLOR(0xEEEEEE) width:1 radius:0];
    [_cancel addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    _cancel.tag = 2;
}

-(void)action:(UIButton *)sender {
    if(_onAction) {
        _onAction(sender.tag);
    }
    [self dismiss];
}

-(void)cancel:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_cancel];
    if([_cancel.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    
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
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards; // 动画结束后停留在最终位置
    
    [self.container.layer addAnimation:animationGroup forKey:nil];
}

- (void)dismiss {
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
    [self.container.layer addAnimation:animationGroup forKey:@"scale"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.container.opaque = 0;
    self.container.frame = CGRectZero;
    [self removeFromSuperview];
}



+ (void)showWithTitle:(NSString *)title 
             subtitle:(NSString *)subtitle
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)confirmHandle
         cancelHandle:(AlertViewCancelHandle)cancelHandle {
    AlertView *alert = [[AlertView alloc] initWithTitle:title subtitle:subtitle confirm:confirm cancel:cancel];
    alert.onAction = ^(NSInteger index) {
        if (index == 1) {
            if (confirmHandle) {
                confirmHandle();
            }
        } else {
            if (cancelHandle) {
                cancelHandle();
            }
        }
    };
    [alert show];
}
+ (void)showWithTitle:(NSString *)title
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)confirmHandle
         cancelHandle:(AlertViewCancelHandle)cancelHandle {
    [self showWithTitle:title subtitle:nil confirm:confirm cancel:cancel confirmHandle:confirmHandle cancelHandle:cancelHandle];
}

+ (void)showWithTitle:(NSString *)title
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)handle {
    [self showWithTitle:title confirm:confirm cancel:cancel confirmHandle:handle cancelHandle:nil];
}
@end
