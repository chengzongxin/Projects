//
//  UIButton+Convenient.m
//  MU
//
//  Created by Joe on 2020/2/13.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import "UIButton+Convenient.h"

@implementation UIButton (Convenient)


+ (instancetype)button {
    return [self buttonWithType:UIButtonTypeCustom];
}

- (void)setTitle:(NSString *_Nullable)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(NSString *_Nullable)image {
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)addTarget:(nullable id)target action:(nonnull SEL)sel {
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (void)setNormalBackGroundColor:(UIColor *)normalColor selectedBackGroundColor:(UIColor *)selectedColor{
    // style
    UIImage *enableBGImage = [self imageWithColor:normalColor];
    UIImage *selectedBGImage = [self imageWithColor:selectedColor];
    [self setBackgroundImage:enableBGImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectedBGImage forState:UIControlStateSelected];
}


- (void)setNormalBackGroundColor:(UIColor *)normalColor disableBackGroundColor:(UIColor *)disableColor{
    // style
    UIImage *enableBGImage = [self imageWithColor:normalColor];
    UIImage *disableBGImage = [self imageWithColor:disableColor];
    [self setBackgroundImage:enableBGImage forState:UIControlStateNormal];
    [self setBackgroundImage:disableBGImage forState:UIControlStateDisabled];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font{
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}

+ (instancetype)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font backgoundColor:(UIColor *)backgroudColor target:(id)target action:(SEL)sel{
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    btn.backgroundColor = backgroudColor;
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)topImageButton:(UIButton *)btn space:(CGFloat)space {
    float spacing = space;//图片和文字的上下间距
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0);
}

- (void)buttonImageTitleWithStyle:(MTFYButtonImageTitleStyle)style
                          padding:(CGFloat)padding {
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        
        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;
        
        switch (style) {
            case MTFYButtonImageTitleStyleLeft:
                if (padding != 0) {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding / 2, 0, -padding / 2);
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding / 2, 0, padding / 2);
                }
                break;
            case MTFYButtonImageTitleStyleRight: {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding / 2), 0, (imageRect.size.width + padding / 2));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width + padding / 2), 0, -(titleRect.size.width + padding / 2));
            }
                break;
            case MTFYButtonImageTitleStyleTop: {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
                
            }
                break;
            case MTFYButtonImageTitleStyleBottom: {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(
                                                        ((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case MTFYButtonImageTitleStyleCenterTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        -(titleRect.origin.y - padding),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y - padding),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(
                                                        0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case MTFYButtonImageTitleStyleCenterBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        (selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                                                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                                                        0,
                                                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case MTFYButtonImageTitleStyleCenterUp: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        -(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case MTFYButtonImageTitleStyleCenterDown: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                                                        (imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                                                        -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                                                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), 0, -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case MTFYButtonImageTitleStyleRightLeft: {
                //图片在右，文字在左，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(titleRect.origin.x - padding), 0, (titleRect.origin.x - padding));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - imageRect.origin.x - imageRect.size.width), 0, -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
            }
                break;
            case MTFYButtonImageTitleStyleLeftRight: {
                //图片在左，文字在右，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(0, (selfWidth - padding - titleRect.origin.x - titleRect.size.width), 0, -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.origin.x - padding), 0, (imageRect.origin.x - padding));
            }
                break;
            default:
                break;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)setImagePosition:(OXImagePosition)postion spacing:(CGFloat)spacing {
    CGSize imageSize    = self.imageView.image.size;
    CGFloat imageWidth  = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize labelSize    = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
#pragma clang diagnostic pop
    CGFloat labelWidth  = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    //image中心移动的x距离
    CGFloat imageOffsetX = (imageWidth + labelWidth)/2 - imageWidth/2;
    //image中心移动的y距离
    CGFloat imageOffsetY = imageHeight/2 + spacing/2;
    
    //label中心移动的x距离
    CGFloat labelOffsetX = (imageWidth + labelWidth/2) - (imageWidth + labelWidth)/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = labelHeight/2 + spacing/2;
    
    switch (postion)
    {
        case OXImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
        case OXImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            break;
        case OXImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            break;
        case OXImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            break;
            
        default:
            break;
    }
}
@end
