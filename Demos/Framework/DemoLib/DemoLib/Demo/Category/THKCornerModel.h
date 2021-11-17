//
//  THKCornerModel.h
//  THKCorner
//
//  Created by amby on 2020/05/16.
//  Copyright © 2020 binxun. All rights reserved.
//

#import <Foundation/Foundation.h>

struct THKRectRadius {
    CGFloat topLeft;     //The radius of topLeft.     左上半径
    CGFloat topRight;    //The radius of topRight.    右上半径
    CGFloat bottomLeft;   //The radius of bottomLeft.   左下半径
    CGFloat bottomRight;  //The radius of bottomRight.  右下半径
};
typedef struct THKRectRadius THKRectRadius;

static THKRectRadius const THKRectRadiusZero = (THKRectRadius){0, 0, 0, 0};

NS_INLINE bool THKRectRadiusIsEqual(THKRectRadius radius1, THKRectRadius radius2) {
    return radius1.topLeft == radius2.topLeft && radius1.topRight == radius2.topRight && radius1.bottomLeft == radius2.bottomLeft && radius1.bottomRight == radius2.bottomRight;
}

NS_INLINE THKRectRadius THKRectRadiusMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight) {
    THKRectRadius radius;
    radius.topLeft = topLeft;
    radius.topRight = topRight;
    radius.bottomLeft = bottomLeft;
    radius.bottomRight = bottomRight;
    return radius;
}

NS_INLINE THKRectRadius THKRectRadiusMakeSame(CGFloat radius) {
    THKRectRadius result;
    result.topLeft = radius;
    result.topRight = radius;
    result.bottomLeft = radius;
    result.bottomRight = radius;
    return result;
}


typedef NS_ENUM(NSUInteger, THKGradualChangeType) {
    THKGradualChangeTypeLeftToRight,
    THKGradualChangeTypeTopLeftToBottomRight,
    THKGradualChangeTypeTopToBottom,
    THKGradualChangeTypeTopRightToBottomLeft,
    THKGradualChangeTypeBottomRightToTopLeft,
    THKGradualChangeTypeBottomLeftToTopRight,
};


@interface THKGradualChangingColor : NSObject

@property (nonatomic, copy) NSArray<UIColor *> *colors;//多颜色渐变，如果数组有值，则忽略fromColor和toColor
@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;
@property (nonatomic, assign) THKGradualChangeType type;

@end


@interface THKCorner : NSObject

/**The radiuses of 4 corners.   4个圆角的半径*/
@property (nonatomic, assign) THKRectRadius radius;
/**The color that will fill the layer/view. 将要填充layer/view的颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/**The color of the border. 边框颜色*/
@property (nonatomic, strong) UIColor *borderColor;
/**The lineWidth of the border. 边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;

@end
