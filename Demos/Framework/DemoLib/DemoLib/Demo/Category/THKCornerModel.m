//
//  THKCornerModel.m
//  THKCorner
//
//  Created by amby on 2020/05/16.
//  Copyright © 2020 binxun. All rights reserved.
//

#import "THKCornerModel.h"

@implementation THKGradualChangingColor

- (instancetype)initWithColorFrom:(UIColor *)from to:(UIColor *)to type:(THKGradualChangeType)type {
    if (self = [super init]) {
        _fromColor = from;
        _toColor = to;
        _type = type;
    }
    return self;
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to {
    return [[self alloc] initWithColorFrom:from to:to type:THKGradualChangeTypeTopLeftToBottomRight];
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to type:(THKGradualChangeType)type {
    return [[self alloc] initWithColorFrom:from to:to type:type];
}

@end


@implementation THKCorner

- (instancetype)initWithRadius:(THKRectRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self = [super init]) {
        _radius = radius;
        _fillColor = fillColor;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
    }
    return self;
}

+ (instancetype)cornerWithRadius:(THKRectRadius)radius fillColor:(UIColor *)fillColor {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:nil borderWidth:0];
}

+ (instancetype)cornerWithRadius:(THKRectRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:borderColor borderWidth:borderWidth];
}

@end
