//
//  TMSearchPresentationAnimatedTransition.h
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/7.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TMSearchPresentationAnimatedTransitionType) {
    TMSearchPresentationAnimatedTransitionTypePresent = 0,
    TMSearchPresentationAnimatedTransitionTypeDismiss
};

@interface TMSearchPresentationAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign)TMSearchPresentationAnimatedTransitionType currentType;

+ (instancetype)transitionWithTransitionType:(TMSearchPresentationAnimatedTransitionType)type;

@end

NS_ASSUME_NONNULL_END
