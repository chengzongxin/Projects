//
//  UIViewController+Page.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/10.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "UIViewController+Page.h"
#import <objc/runtime.h>

@implementation UIViewController (Page)


- (BOOL)notScrollView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNotScrollView:(BOOL)notScrollView{
    objc_setAssociatedObject(self, @selector(notScrollView), @(notScrollView), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
