//
//  SkinDoudouCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinDoudouCell.h"

@implementation SkinDoudouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NSString *)model{
    [super setModel:model];
    
    if ([model containsString:@"1"]) {
        _imgV.image = [UIImage imageNamed:@"animation_man"];
    }else{
        _imgV.image = [UIImage imageNamed:@"qian"];
        _imgV.image = [self imageWithOriginalName:_imgV.image signColor:[UIColor redColor] signPositionX:@[@0.4,@0.3] ignPositionY:@[@0.5,@0.7]];
    }
}



// 给图片添加标记
- (UIImage *)imageWithOriginalName:(UIImage *)image signColor:(UIColor *)signColor signPositionX:(NSArray *)positionX ignPositionY:(NSArray *)positionY {
    
    //1.获取标注图片
    UIImage *signalImage = [UIImage imageNamed:@"skin_warning_circle"]; // [self circleImage:[self imageWithColor:signColor]];
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
//    for (NSNumber *num in positionX) {
//        num.floatValue
//    }
    for (int i = 0; i < positionX.count; i++) {
        NSNumber *numX = positionX[i];
        NSNumber *numY = positionY[i];
        
        //绘制标记图片到当前上下文
        CGFloat signX = numX.floatValue * image.size.width;
        CGFloat signY = numY.floatValue * image.size.height;
        
        CGRect rect = CGRectMake(signX, signY, signalImage.size.width, signalImage.size.height);
        [signalImage drawInRect:rect];
    }
    
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor.clearColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  圆形图片
 *
 *  @return 圆形图片
 */
- (UIImage *)circleImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef imgRef = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextAddEllipseInRect(imgRef, rect);
    
    CGContextClip(imgRef);
    [image drawInRect:rect];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

@end
