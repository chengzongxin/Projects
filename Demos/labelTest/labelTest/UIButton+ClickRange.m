//
//  UIButton+ClickRange.m
//  MyCustomDemo
//
//  Created by sx on 2019/11/29.
//  Copyright © 2019 sx. All rights reserved.
//

#import "UIButton+ClickRange.h"
#import <objc/runtime.h>

@implementation UIButton (ClickRange)
#pragma mark - Constant
static const char * kClickExpandInsets = "kClickExpandInsets";
static const char * kClickExpandScale = "kExpandScale";
static const char * kClickExpandWidthScale = "kClickExpandWidthScale";
static const char * kClickExpandHeightSCale = "kClickExpandHeightSCale";

#pragma mark - Set
- (void)setClickEdgeInsets:(UIEdgeInsets)clickEdgeInsets {
    NSValue *value = [NSValue value:&clickEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, kClickExpandInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setClickScale:(CGFloat)clickScale {
    CGFloat width = self.bounds.size.width * clickScale;
    CGFloat height = self.bounds.size.height * clickScale;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    objc_setAssociatedObject(self, kClickExpandScale, [NSNumber numberWithFloat:clickScale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setClickWidthScale:(CGFloat)clickWidthScale {
    CGFloat width = self.bounds.size.width * clickWidthScale;
    CGFloat height = self.bounds.size.height;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    objc_setAssociatedObject(self, kClickExpandWidthScale, [NSNumber numberWithFloat:clickWidthScale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setClickHeightScale:(CGFloat)clickHeightScale {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * clickHeightScale;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width, -height, -width);
    objc_setAssociatedObject(self, kClickExpandHeightSCale, [NSNumber numberWithFloat:clickHeightScale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Get
- (CGFloat)clickScale {
    return [objc_getAssociatedObject(self, kClickExpandScale) floatValue];
}

- (UIEdgeInsets)clickEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, kClickExpandInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets:UIEdgeInsetsZero;
}

- (CGFloat)clickWidthScale {
    return [objc_getAssociatedObject(self, kClickExpandWidthScale) floatValue];
}

- (CGFloat)clickHeightScale {
    return [objc_getAssociatedObject(self, kClickExpandHeightSCale) floatValue];
}

#pragma mark - Super
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"clickrange");
    // 如果 button 边界值变化、失效、隐藏或者透明，则直接返回
    if (UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero)
        || !self.enabled
        || self.hidden
        || self.alpha == 0) {
        return [super pointInside:point withEvent:event];
    } else {
        CGRect relativeFrame = self.bounds;
        CGRect clickFrame = UIEdgeInsetsInsetRect(relativeFrame, self.clickEdgeInsets);
        return CGRectContainsPoint(clickFrame, point);
    }
}

@end
