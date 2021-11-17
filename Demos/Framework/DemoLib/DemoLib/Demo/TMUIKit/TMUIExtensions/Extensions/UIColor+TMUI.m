//
//  UIColor+TMUI.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/15.
//

#import "UIColor+TMUI.h"

@implementation UIColor (TMUI)

+ (UIColor *)tmui_colorWithHexString:(NSString *)hexString {
    if (hexString.length <= 0) return nil;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 1];
            green = [self _colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 1];
            red   = [self _colorComponentFrom: colorString start: 1 length: 1];
            green = [self _colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 2];
            green = [self _colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 2];
            red   = [self _colorComponentFrom: colorString start: 2 length: 2];
            green = [self _colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 6 length: 2];
            break;
        default: {
            NSAssert(NO, @"Color value %@ is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString);
            return nil;
        }
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)_colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (CGFloat)tmui_red {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0;
}

- (CGFloat)tmui_green {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0;
}

- (CGFloat)tmui_blue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (CGFloat)tmui_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

- (UIColor *)tmui_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor tmui_colorFromColor:self toColor:toColor progress:progress];
}

- (BOOL)tmui_colorIsDark {
    CGFloat red = 0.0, green = 0.0, blue = 0.0;
    if ([self getRed:&red green:&green blue:&blue alpha:0]) {
        float referenceValue = 0.411;
        float colorDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
        
        return 1.0 - colorDelta > referenceValue;
    }
    return YES;
}

- (UIColor *)tmui_inverseColor {
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

+ (UIColor *)tmui_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    progress = MAX(progress, 0.0f);
    CGFloat fromRed = fromColor.tmui_red;
    CGFloat fromGreen = fromColor.tmui_green;
    CGFloat fromBlue = fromColor.tmui_blue;
    CGFloat fromAlpha = fromColor.tmui_alpha;
    
    CGFloat toRed = toColor.tmui_red;
    CGFloat toGreen = toColor.tmui_green;
    CGFloat toBlue = toColor.tmui_blue;
    CGFloat toAlpha = toColor.tmui_alpha;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}

+ (UIColor *)tmui_randomColor {
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
