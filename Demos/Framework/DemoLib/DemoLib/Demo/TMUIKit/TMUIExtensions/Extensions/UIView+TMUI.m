//
//  UIView+TMUI.m
//  TMUIKitDemo
//
//  Created by nigel.ning on 2020/4/14.
//  Copyright © 2020 t8t. All rights reserved.
//

#import "UIView+TMUI.h"

@implementation UIView (TMUI)

- (UIViewController *)tmui_viewController {
    return [[self class] tmui_viewControllerOfView:self];
}

+ (UIViewController *)tmui_viewControllerOfView:(UIView *)view {
    UIResponder *nextResponder = view;
    do {
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    } while (nextResponder != nil);

    return nil;
}

@end
