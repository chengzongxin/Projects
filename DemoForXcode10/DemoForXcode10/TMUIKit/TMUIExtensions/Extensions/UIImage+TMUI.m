//
//  UIImage+TMUI.m
//  Pods-TMUIKitDemo
//
//  Created by nigel.ning on 2020/4/15.
//

#import "UIImage+TMUI.h"
#import "TMUICore.h"
#import "UIColor+TMUI.h"

#ifdef DEBUG
#define CGContextInspectContext(context) { \
    if(!context) {NSAssert(NO, @"非法的contenxt, %@:%d %s", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__);} }
#else
#define CGContextInspectContext(context)
#endif


@implementation UIImage (TMUI)


+ (nullable UIImage *)tmui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock {
    if (!actionBlock || CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextInspectContext(context);
    actionBlock(context);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (UIColor *)tmui_averageColor {
    unsigned char rgba[4] = {};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextInspectContext(context);
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if(rgba[3] > 0) {
        return [UIColor colorWithRed:((CGFloat)rgba[0] / rgba[3])
                               green:((CGFloat)rgba[1] / rgba[3])
                                blue:((CGFloat)rgba[2] / rgba[3])
                               alpha:((CGFloat)rgba[3] / 255.0)];
    } else {
        return [UIColor colorWithRed:((CGFloat)rgba[0]) / 255.0
                               green:((CGFloat)rgba[1]) / 255.0
                                blue:((CGFloat)rgba[2]) / 255.0
                               alpha:((CGFloat)rgba[3]) / 255.0];
    }
}


- (CGSize)tmui_sizeInPixel {
    CGSize size = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    return size;
}

- (BOOL)tmui_opaque {
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    return opaque;
}

- (nullable UIImage *)tmui_grayImage {
    // CGBitmapContextCreate 是无倍数的，所以要自己换算成1倍
    CGSize size = self.tmui_sizeInPixel;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault);
    CGContextInspectContext(context);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGRect imageRect = CGRectMakeWithSize(size);
    CGContextDrawImage(context, imageRect, self.CGImage);
    
    UIImage *grayImage = nil;
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    if (self.tmui_opaque) {
        grayImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    } else {
        CGContextRef alphaContext = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, nil, kCGImageAlphaOnly);
        CGContextDrawImage(alphaContext, imageRect, self.CGImage);
        CGImageRef mask = CGBitmapContextCreateImage(alphaContext);
        CGImageRef maskedGrayImageRef = CGImageCreateWithMask(imageRef, mask);
        grayImage = [UIImage imageWithCGImage:maskedGrayImageRef scale:self.scale orientation:self.imageOrientation];
        CGImageRelease(mask);
        CGImageRelease(maskedGrayImageRef);
        CGContextRelease(alphaContext);
        
        // 用 CGBitmapContextCreateImage 方式创建出来的图片，CGImageAlphaInfo 总是为 CGImageAlphaInfoNone，导致 tmui_opaque 与原图不一致，所以这里再做多一步
        grayImage = [UIImage tmui_imageWithSize:grayImage.size opaque:NO scale:grayImage.scale actions:^(CGContextRef contextRef) {
            [grayImage drawInRect:CGRectMakeWithSize(grayImage.size)];
        }];
    }
    
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return grayImage;
}

- (nullable UIImage *)tmui_imageWithAlpha:(CGFloat)alpha {
    return [UIImage tmui_imageWithSize:self.size opaque:NO scale:self.scale actions:^(CGContextRef contextRef) {
        [self drawInRect:CGRectMakeWithSize(self.size) blendMode:kCGBlendModeNormal alpha:alpha];
    }];
}

- (nullable UIImage *)tmui_imageWithTintColor:(nullable UIColor *)tintColor {
    // iOS 13 的 imageWithTintColor: 方法里并不会去更新 CGImage，所以通过它更改了图片颜色后再获取到的 CGImage 依然是旧的，因此暂不使用
    //#ifdef IOS13_SDK_ALLOWED
    //    if (@available(iOS 13.0, *)) {
    //        return [self imageWithTintColor:tintColor];
    //    }
    //#endif
        return [UIImage tmui_imageWithSize:self.size opaque:self.tmui_opaque scale:self.scale actions:^(CGContextRef contextRef) {
            CGContextTranslateCTM(contextRef, 0, self.size.height);
            CGContextScaleCTM(contextRef, 1.0, -1.0);
            CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
            CGContextClipToMask(contextRef, CGRectMakeWithSize(self.size), self.CGImage);
            CGContextSetFillColorWithColor(contextRef, tintColor.CGColor);
            CGContextFillRect(contextRef, CGRectMakeWithSize(self.size));
        }];
}

- (nullable UIImage *)tmui_imageWithSpacingExtensionInsets:(UIEdgeInsets)extension {
    CGSize contextSize = CGSizeMake(self.size.width + UIEdgeInsetsGetHorizontalValue(extension), self.size.height + UIEdgeInsetsGetVerticalValue(extension));
    return [UIImage tmui_imageWithSize:contextSize opaque:self.tmui_opaque scale:self.scale actions:^(CGContextRef contextRef) {
        [self drawAtPoint:CGPointMake(extension.left, extension.top)];
    }];
}


- (nullable UIImage *)tmui_imageWithOrientation:(UIImageOrientation)orientation {
    if (orientation == UIImageOrientationUp) {
        return self;
    }
    
    CGSize contextSize = self.size;
    if (orientation == UIImageOrientationLeft || orientation == UIImageOrientationRight) {
        contextSize = CGSizeMake(contextSize.height, contextSize.width);
    }
            
    return [UIImage tmui_imageWithSize:contextSize opaque:NO scale:self.scale actions:^(CGContextRef contextRef) {
        // 画布的原点在左上角，旋转后可能图片就飞到画布外了，所以旋转前先把图片摆到特定位置再旋转，图片刚好就落在画布里
        switch (orientation) {
            case UIImageOrientationUp:
                // 上
                break;
            case UIImageOrientationDown:
                // 下
                CGContextTranslateCTM(contextRef, contextSize.width, contextSize.height);
                CGContextRotateCTM(contextRef, TMUI_AngleWithDegrees(180));
                break;
            case UIImageOrientationLeft:
                // 左
                CGContextTranslateCTM(contextRef, 0, contextSize.height);
                CGContextRotateCTM(contextRef, TMUI_AngleWithDegrees(-90));
                break;
            case UIImageOrientationRight:
                // 右
                CGContextTranslateCTM(contextRef, contextSize.width, 0);
                CGContextRotateCTM(contextRef, TMUI_AngleWithDegrees(90));
                break;
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                // 向上、向下翻转是一样的
                CGContextTranslateCTM(contextRef, 0, contextSize.height);
                CGContextScaleCTM(contextRef, 1, -1);
                break;
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                // 向左、向右翻转是一样的
                CGContextTranslateCTM(contextRef, contextSize.width, 0);
                CGContextScaleCTM(contextRef, -1, 1);
                break;
        }
        
        // 在前面画布的旋转、移动的结果上绘制自身即可，这里不用考虑旋转带来的宽高置换的问题
        [self drawInRect:CGRectMakeWithSize(self.size)];
    }];
}

#pragma mark - generate color image

+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color {
    return [UIImage tmui_imageWithColor:color size:CGSizeMake(4, 4)];
}

+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color size:(CGSize)size {
    return [UIImage tmui_imageWithColor:color size:size cornerRadius:0];
}

+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
        
    color = color ? color : [UIColor clearColor];
    BOOL opaque = (cornerRadius == 0.0 && [color tmui_alpha] == 1.0);
    return [UIImage tmui_imageWithSize:size opaque:opaque scale:0 actions:^(CGContextRef contextRef) {
        CGContextSetFillColorWithColor(contextRef, color.CGColor);
        
        if (cornerRadius > 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMakeWithSize(size) cornerRadius:cornerRadius];
            [path addClip];
            [path fill];
        } else {
            CGContextFillRect(contextRef, CGRectMakeWithSize(size));
        }
    }];
}

#pragma mark - generate shape image

+ (UIImage *)tmui_imageWithShape:(TMUIImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat lineWidth = 0;
    switch (shape) {
        case TMUIImageShapeNavBack:
            lineWidth = 2.0f;
            break;
        case TMUIImageShapeDisclosureIndicator:
            lineWidth = 1.5f;
            break;
        case TMUIImageShapeCheckmark:
            lineWidth = 1.5f;
            break;
        case TMUIImageShapeDetailButtonImage:
            lineWidth = 1.0f;
            break;
        case TMUIImageShapeNavClose:
            lineWidth = 1.2f;   // 取消icon默认的lineWidth
            break;
        default:
            break;
    }
    return [UIImage tmui_imageWithShape:shape size:size lineWidth:lineWidth tintColor:tintColor];
}

+ (nullable UIImage *)tmui_imageWithShape:(TMUIImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(nullable UIColor *)tintColor {
    
    tintColor = tintColor ? : [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    return [UIImage tmui_imageWithSize:size opaque:NO scale:0 actions:^(CGContextRef contextRef) {
        UIBezierPath *path = nil;
        BOOL drawByStroke = NO;
        CGFloat drawOffset = lineWidth / 2;
        switch (shape) {
            case TMUIImageShapeOval: {
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectMakeWithSize(size)];
            }
                break;
            case TMUIImageShapeTriangle: {
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, size.height)];
                [path addLineToPoint:CGPointMake(size.width / 2, 0)];
                [path addLineToPoint:CGPointMake(size.width, size.height)];
                [path closePath];
            }
                break;
            case TMUIImageShapeNavBack: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                path.lineWidth = lineWidth;
                [path moveToPoint:CGPointMake(size.width - drawOffset, drawOffset)];
                [path addLineToPoint:CGPointMake(0 + drawOffset, size.height / 2.0)];
                [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height - drawOffset)];
            }
                break;
            case TMUIImageShapeDisclosureIndicator: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                path.lineWidth = lineWidth;
                [path moveToPoint:CGPointMake(drawOffset, drawOffset)];
                [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height / 2)];
                [path addLineToPoint:CGPointMake(drawOffset, size.height - drawOffset)];
            }
                break;
            case TMUIImageShapeCheckmark: {
                CGFloat lineAngle = M_PI_4;
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, size.height / 2)];
                [path addLineToPoint:CGPointMake(size.width / 3, size.height)];
                [path addLineToPoint:CGPointMake(size.width, lineWidth * sin(lineAngle))];
                [path addLineToPoint:CGPointMake(size.width - lineWidth * cos(lineAngle), 0)];
                [path addLineToPoint:CGPointMake(size.width / 3, size.height - lineWidth / sin(lineAngle))];
                [path addLineToPoint:CGPointMake(lineWidth * sin(lineAngle), size.height / 2 - lineWidth * sin(lineAngle))];
                [path closePath];
            }
                break;
            case TMUIImageShapeDetailButtonImage: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMakeWithSize(size), drawOffset, drawOffset)];
                path.lineWidth = lineWidth;
            }
                break;
            case TMUIImageShapeNavClose: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, 0)];
                [path addLineToPoint:CGPointMake(size.width, size.height)];
                [path closePath];
                [path moveToPoint:CGPointMake(size.width, 0)];
                [path addLineToPoint:CGPointMake(0, size.height)];
                [path closePath];
                path.lineWidth = lineWidth;
                path.lineCapStyle = kCGLineCapRound;
            }
                break;
            default:
                break;
        }
        
        if (drawByStroke) {
            CGContextSetStrokeColorWithColor(contextRef, tintColor.CGColor);
            [path stroke];
        } else {
            CGContextSetFillColorWithColor(contextRef, tintColor.CGColor);
            [path fill];
        }
        
        if (shape == TMUIImageShapeDetailButtonImage) {
            CGFloat fontPointSize = ceilf(size.height * 0.8);
            UIFont *font = [UIFont fontWithName:@"Georgia" size:fontPointSize];
            NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"i" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: tintColor}];
            CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesFontLeading context:nil].size;
            [string drawAtPoint:CGPointMake(CGFloatGetCenter(size.width, stringSize.width), CGFloatGetCenter(size.height, stringSize.height))];
        }
    }];
}

#pragma mark - 截图

+ (nullable UIImage *)tmui_imageWithView:(UIView *)view {
    return [UIImage tmui_imageWithSize:view.bounds.size opaque:NO scale:0 actions:^(CGContextRef contextRef) {
        [view.layer renderInContext:contextRef];
    }];
}

@end
