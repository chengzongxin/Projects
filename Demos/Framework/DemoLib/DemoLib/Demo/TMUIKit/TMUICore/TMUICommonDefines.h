//
//  TMUICommonDefines.h
//  Pods
//
//  Created by nigel.ning on 2020/4/15.
//

#ifndef TMUICommonDefines_h
#define TMUICommonDefines_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/// !!!: 此处定义的宏定义均以 TMUI_ 为前缀, 若为内联函数则以小写的tmui_为前缀

/// 屏幕宽度，会根据横竖屏的变化而变化
#define TMUI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/// 屏幕高度，会根据横竖屏的变化而变化
#define TMUI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
#define TMUI_StatusBarHeight (UIApplication.sharedApplication.statusBarHidden ? 0 : UIApplication.sharedApplication.statusBarFrame.size.height)

/// app的主winodw
#define TMUI_AppWindow [UIApplication sharedApplication].delegate.window

///获取一个像素
#define TMUI_PixelOne tmui_pixelOne()

NS_INLINE CGFloat
tmui_pixelOne() {
    static CGFloat _tmui_pixelOne = -1.0f;
    if (_tmui_pixelOne < 0) {
        _tmui_pixelOne = 1.0f / [[UIScreen mainScreen] scale];
    }
    return _tmui_pixelOne;
}

#pragma mark - 上下内容安全边距
NS_INLINE CGFloat
tmui_safeAreaTopInset(){
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
        top = TMUI_AppWindow.safeAreaInsets.top;
    }
    return top;
}

NS_INLINE CGFloat
tmui_safeAreaBottomInset(){
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = TMUI_AppWindow.safeAreaInsets.bottom;
    }
    return bottom;
}

#pragma mark - 数学计算

/// 角度转弧度
#define TMUI_AngleWithDegrees(deg) (M_PI * (deg) / 180.0)

#pragma mark - 通用辅助宏

#pragma mark - weakify & strongify (reactcocoa库里的简化版本，只支持一个参数)

#if DEBUG
#define tmui_keywordify autoreleasepool {}
#else
#define tmui_keywordify try {} @catch (...) {}
#endif

#define TMUI_weakify(obj) \
tmui_keywordify \
    __weak __typeof__(obj) obj##_tmui_weak_ = obj;

#define TMUI_strongify(obj) \
tmui_keywordify \
    __strong __typeof__(obj) obj = obj##_tmui_weak_;


#pragma mark - Debug Code & Logger Helpers
///可用于调试的代码，宏参数里的代码仅在DEBUG模式下会有效执行
#if DEBUG
#define TMUI_DEBUG_Code(...) \
    __VA_ARGS__;
#else
#define TMUI_DEBUG_Code(...)
#endif

///用于调试时重写类的dealloc方法并打印相关log的便捷宏
#define TMUI_DEBUG_Code_Dealloc \
TMUI_DEBUG_Code (   \
- (void)dealloc {   \
NSLog(@"dealloc: %@", NSStringFromClass(self.class));   \
}   \
)   \

///用于调试时重写类的dealloc方法并打印相关log及添加其它额外代码的便捷宏
#define TMUI_DEBUG_Code_Dealloc_Other(...) \
TMUI_DEBUG_Code (   \
- (void)dealloc {   \
NSLog(@"dealloc: %@", NSStringFromClass(self.class));   \
    __VA_ARGS__;    \
}   \
)   \

#pragma mark - 普通对象懒加载宏

///协议属性的synthesize声明宏
#define TMUI_PropertySyntheSize(propertyName) \
@synthesize propertyName = _##propertyName;

///NSObject类型的属性的懒加载宏
#define TMUI_PropertyLazyLoad(Type, propertyName) \
- (Type *)propertyName { \
    if (!_##propertyName) {\
        _##propertyName = [[Type alloc] init]; \
    } \
    return _##propertyName; \
}   \

#endif /* TMUICommonDefines_h */
