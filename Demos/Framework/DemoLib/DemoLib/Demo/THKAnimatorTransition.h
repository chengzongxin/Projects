//
//  THKTransitionAnimator.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    THKTransitionStylePresent,
    THKTransitionStyleDismiss,
    THKTransitionStylePush,
    THKTransitionStylePop
} THKTransitionStyle;

typedef enum : NSUInteger {
    THKTransitionGestureDirectionLeft,
    THKTransitionGestureDirectionRight,
    THKTransitionGestureDirectionUp,
    THKTransitionGestureDirectionDown
} THKTransitionGestureDirection;

@interface THKAnimatorTransition : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning,CAAnimationDelegate,UINavigationControllerDelegate>

/// 动画执行时生成的ImageView
@property (nonatomic, strong) UIImageView *animateImageView;
/// ImageView的Frame
@property (nonatomic, assign) CGRect imgFrame;
/// 滑动阀值
@property (nonatomic, assign) float scrollThreshold;
/// 添加手势
- (void)addGestureWithVC:(UIViewController *)vc direction:(THKTransitionGestureDirection)direction;
/// 传入原始ImageView
@property (nonatomic, strong) UIImageView *originImageView;

@end

NS_ASSUME_NONNULL_END
