//
//  UIBezierPath+Extension.m
//  画板
//
//  Created by Joe on 2019/7/8.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import "UIBezierPath+Extension.h"
#import <objc/runtime.h>

@implementation UIBezierPath (Extension)

- (UIColor *)color{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setColor:(UIColor *)color{
    objc_setAssociatedObject(self, @selector(color), color, OBJC_ASSOCIATION_RETAIN);
}

@end
