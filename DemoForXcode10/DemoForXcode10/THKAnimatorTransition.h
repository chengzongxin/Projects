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

@property (nonatomic, strong) UIImageView *animateImageView;

@property (nonatomic, assign) CGRect imgFrame;

@property (nonatomic, assign) float scrollThreshold;

- (void)addGestureWithVC:(UIViewController *)vc direction:(THKTransitionGestureDirection)direction;

@end

NS_ASSUME_NONNULL_END
