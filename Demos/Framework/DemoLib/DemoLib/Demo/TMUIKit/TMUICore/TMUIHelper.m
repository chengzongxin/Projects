//
//  TMUIHelper.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/15.
//

#import "TMUIHelper.h"

@implementation TMUIHelper

@end

@implementation TMUIHelper (Animation)

+ (void)executeAnimationBlock:(__attribute__((noescape)) void (^)(void))animationBlock completionBlock:(__attribute__((noescape)) void (^)(void))completionBlock {
    if (!animationBlock) return;
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionBlock];
    animationBlock();
    [CATransaction commit];
}

@end
