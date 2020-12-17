//
//  UIImage+THKCorner.m
//  THKCorner
//
//  Created by amby on 2020/05/16.
//  Copyright © 2020 binxun. All rights reserved.
//

#import "UIImage+THKCorner.h"
#import "THKCornerModel.h"

@implementation UIImage (THKCorner)

static UIBezierPath * thk_pathWithCornerRadius(THKRectRadius radius, CGSize size) {
    CGFloat imgW = size.width;
    CGFloat imgH = size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.bottomLeft, imgH - radius.bottomLeft) radius:radius.bottomLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.topLeft, radius.topLeft) radius:radius.topLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(imgW - radius.topRight, radius.topRight) radius:radius.topRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(imgW - radius.bottomRight, imgH - radius.bottomRight) radius:radius.bottomRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    return path;
}

+ (UIImage *)imageWithGradualChangingColor:(void (^)(THKGradualChangingColor *))handler size:(CGSize)size cornerRadius:(THKRectRadius)radius {
    THKGradualChangingColor *graColor = [[THKGradualChangingColor alloc] init];
    if (handler) {
        handler(graColor);
    }
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = (CGRect){CGPointZero, size};
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0;
    switch (graColor.type) {
        case THKGradualChangeTypeTopLeftToBottomRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 1;
        }
            break;
        case THKGradualChangeTypeTopToBottom: {
            startX = 0;
            startY = 0;
            endX = 0;
            endY = 1;
        }
            break;
        case THKGradualChangeTypeLeftToRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 0;
        }
            break;
        case THKGradualChangeTypeTopRightToBottomLeft: {
            startX = 0;
            startY = 1;
            endX = 1;
            endY = 0;
        }
            break;
        case THKGradualChangeTypeBottomRightToTopLeft: {
            startX = 1;
            startY = 1;
            endX = 0;
            endY = 0;
        }
            break;
        case THKGradualChangeTypeBottomLeftToTopRight: {
            startX = 1;
            startY = 0;
            endX = 1;
            endY = 0;
        }
            break;
    }
    graLayer.startPoint = CGPointMake(startX, startY);
    graLayer.endPoint = CGPointMake(endX, endY);
    
    if (graColor.colors && graColor.colors.count > 0) {//首先判断颜色数组是否有值
        NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:graColor.colors.count];
        NSMutableArray *arrayLocationsTemp = [NSMutableArray arrayWithCapacity:graColor.colors.count];
        CGFloat offset = 1.0 / graColor.colors.count;
        [graColor.colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayTemp addObject:(__bridge id)obj.CGColor];
            CGFloat loc = offset * idx;
            if (loc > 1.0) {
                loc = 1.0;
            }
            [arrayLocationsTemp addObject:@(loc)];
        }];
        graLayer.colors = arrayTemp;
        graLayer.locations = arrayLocationsTemp;
    } else {
        graLayer.colors = @[(__bridge id)graColor.fromColor.CGColor, (__bridge id)graColor.toColor.CGColor];
        graLayer.locations = @[@0.0, @1.0];
    }
    return [self imageWithLayer:graLayer cornerRadius:radius];
}

+ (UIImage *)imageWithTHKCorner:(void (^)(THKCorner *))handler size:(CGSize)size {
    @autoreleasepool {
        THKCorner *corner = [[THKCorner alloc] init];
        if (handler) {
            handler(corner);
        }
        if (!corner.fillColor) {
            corner.fillColor = [UIColor clearColor];
        }
        UIBezierPath *path = thk_pathWithCornerRadius(corner.radius, size);
        if (@available(iOS 10.0, *)) {
            UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
            return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                CGContextSetStrokeColorWithColor(rendererContext.CGContext, corner.borderColor.CGColor);
                CGContextSetFillColorWithColor(rendererContext.CGContext, corner.fillColor.CGColor);
                CGContextSetLineWidth(rendererContext.CGContext, corner.borderWidth);
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
                CGContextDrawPath(rendererContext.CGContext, kCGPathFillStroke);
            }];
        } else {
            UIGraphicsBeginImageContext(size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(context, corner.borderColor.CGColor);
            CGContextSetFillColorWithColor(context, corner.fillColor.CGColor);
            CGContextSetLineWidth(context, corner.borderWidth);
            CGContextAddPath(context, path.CGPath);
            [path addClip];
            CGContextDrawPath(context, kCGPathFillStroke);
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    }
}

- (UIImage *)imageByAddingCornerRadius:(THKRectRadius)radius {
    @autoreleasepool {
        UIBezierPath *path = thk_pathWithCornerRadius(radius, self.size);
        if (@available(iOS 10.0, *)) {
            UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.size];
            return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
                [self drawInRect:(CGRect){CGPointZero, self.size}];
            }];
        } else {
            UIGraphicsBeginImageContext(self.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [path addClip];
            CGContextAddPath(context, path.CGPath);
            [self drawInRect:(CGRect){CGPointZero, self.size}];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    }
}



+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1) cornerRadius:THKRectRadiusZero];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(THKRectRadius)radius {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
            return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                if (!THKRectRadiusIsEqual(radius, THKRectRadiusZero)) {
                    UIBezierPath *path = thk_pathWithCornerRadius(radius, size);
                    [path addClip];
                    CGContextAddPath(rendererContext.CGContext, path.CGPath);
                }
                CGContextSetFillColorWithColor(rendererContext.CGContext, color.CGColor);
                CGContextFillRect(rendererContext.CGContext, (CGRect){CGPointZero, size});
            }];
        } else {
            UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            if (!THKRectRadiusIsEqual(radius, THKRectRadiusZero)) {
                UIBezierPath *path = thk_pathWithCornerRadius(radius, size);
                [path addClip];
                CGContextAddPath(context, path.CGPath);
            }
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextFillRect(context, (CGRect){CGPointZero, size});
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    }
}

+ (UIImage *)imageWithLayer:(CALayer *)layer cornerRadius:(THKRectRadius)radius {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:layer.bounds.size];
            return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                if (!THKRectRadiusIsEqual(radius, THKRectRadiusZero)) {
                    UIBezierPath *path = thk_pathWithCornerRadius(radius, layer.bounds.size);
                    [path addClip];
                    CGContextAddPath(rendererContext.CGContext, path.CGPath);
                }
                [layer renderInContext:rendererContext.CGContext];
            }];
        } else {
            UIGraphicsBeginImageContext(layer.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            if (!THKRectRadiusIsEqual(radius, THKRectRadiusZero)) {
                UIBezierPath *path = thk_pathWithCornerRadius(radius, layer.bounds.size);
                [path addClip];
                CGContextAddPath(context, path.CGPath);
            }
            [layer renderInContext:context];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    }
}

@end
