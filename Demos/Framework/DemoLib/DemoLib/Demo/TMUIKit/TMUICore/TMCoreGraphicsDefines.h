//
//  TMCoreGraphicsDefines.h
//  Pods
//
//  Created by nigel.ning on 2020/4/15.
//

#ifndef TMCoreGraphicsDefines_h
#define TMCoreGraphicsDefines_h

#import <CoreGraphics/CoreGraphics.h>

/// !!!: 此CoreGraphics库扩展的一些宏定义均以相关CoreGraphics里的结构体名作开头

#pragma mark - CGFloat

/// 检测某个数值如果为 NaN 则将其转换为 0，避免布局中出现 crash
CG_INLINE CGFloat
CGFloatSafeValue(CGFloat value) {
    return isnan(value) ? 0 : value;
}

///用于居中运算
///通常在计算子视图在父视图中显示的位置origin时用到，传入父视图宽或高及子视图宽或高，返回子视图显示时对应的origin的x或y值
CG_INLINE CGFloat
CGFloatGetCenter(CGFloat parent, CGFloat child) {
    return ceilf((parent - child) / 2.0);
}


#pragma mark - CGSize

/// 判断一个 CGSize 是否存在 NaN
CG_INLINE BOOL
CGSizeIsNaN(CGSize size) {
    return isnan(size.width) || isnan(size.height);
}

/// 判断一个 CGSize 是否存在 infinite
CG_INLINE BOOL
CGSizeIsInf(CGSize size) {
    return isinf(size.width) || isinf(size.height);
}

/// 判断一个 CGSize 是否合法（例如不带无穷大的值、不带非法数字）
CG_INLINE BOOL
CGSizeIsValidated(CGSize size) {
    return !CGSizeIsInf(size) && !CGSizeIsNaN(size);
}

/// 检测某个 CGSize 如果存在数值为 NaN 的则将其转换为 0，避免布局中出现 crash
CG_INLINE CGSize
CGSizeSafeValue(CGSize size) {
    return CGSizeMake(CGFloatSafeValue(size.width), CGFloatSafeValue(size.height));
}

/// 将一个 CGSize 以 pt 为单位向上取整
CG_INLINE CGSize
CGSizeCeil(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/// 将一个 CGSize 以 pt 为单位向下取整
CG_INLINE CGSize
CGSizeFloor(CGSize size) {
    return CGSizeMake(floor(size.width), floor(size.height));
}


#pragma mark - CGRect

///用size生成一个origin为{0,0}的rect结构体
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

/// 判断一个 CGRect 是否存在 NaN
CG_INLINE BOOL
CGRectIsNaN(CGRect rect) {
    return isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height);
}

/// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
CG_INLINE BOOL
CGRectIsInf(CGRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y) || isinf(rect.size.width) || isinf(rect.size.height);
}

/// 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）
CG_INLINE BOOL
CGRectIsValidated(CGRect rect) {
    return !CGRectIsInfinite(rect) && !CGRectIsNaN(rect) && !CGRectIsInf(rect);
}

/// 检测某个 CGRect 如果存在数值为 NaN 的则将其转换为 0，避免布局中出现 crash
CG_INLINE CGRect
CGRectSafeValue(CGRect rect) {
    return CGRectMake(CGFloatSafeValue(CGRectGetMinX(rect)), CGFloatSafeValue(CGRectGetMinY(rect)), CGFloatSafeValue(CGRectGetWidth(rect)), CGFloatSafeValue(CGRectGetHeight(rect)));
}


#endif /* TMCoreGraphicsDefines_h */
