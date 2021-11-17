//
//  CustomColor.m
//  Test
//
//  Created by Joe.cheng on 2021/4/7.
//

#import "CustomColor.h"
#import <objc/runtime.h>


@interface CustomColor ()
@property (nonatomic, strong) UIColor *qmui_rawColor;
//@property(nonatomic, copy) UIColor * (^colorBlk)() provider;

@property(nonatomic, copy) UIColor * (^colorBlk)(int);

@property(nonatomic, assign) int count;


@end

@implementation CustomColor

+ (UIColor *)dynamicColor:(int)count blk:(UIColor * _Nonnull (^)(int))block{
    CustomColor *color = CustomColor.new;
    color.count = count;
    color.colorBlk = block;
    return color;
}

- (CGColorRef)CGColor{
    NSLog(@"cgcolor");
//    return UIColor.redColor.CGColor;
    CGColorRef colorRef = [UIColor colorWithCGColor:[self rawColor].CGColor].CGColor;
    return colorRef;
}

- (UIColor *)rawColor{
    UIColor *color = self.colorBlk(self.count);
    return color;
}


- (NSString *)colorSpaceName {
    return [(CustomColor *)[self rawColor] colorSpaceName];
}


- (BOOL)isEqual:(id)object {
    return self == object;// 例如在 UIView setTintColor: 时会比较两个 color 是否相等，如果相等，则不会触发 tintColor 的更新。由于 dynamicColor 实际的返回色值随时可能变化，所以即便当前的 qmui_rawColor 值相等，也不应该认为两个 dynamicColor 相等（有可能 themeProvider block 内的逻辑不一致，只是其中的某个条件下 return 的 qmui_rawColor 恰好相同而已），所以这里直接返回 NO。
}

- (NSUInteger)hash {
    return (NSUInteger)self.colorBlk;// 与 UIDynamicProviderColor 相同
}




#pragma mark - ovvv
- (UIColor *)qmui_rawColor{
    return [self rawColor];
}


#pragma mark - Override

- (void)set {
    [self.qmui_rawColor set];
}

- (void)setFill {
    [self.qmui_rawColor setFill];
}

- (void)setStroke {
    [self.qmui_rawColor setStroke];
}

- (BOOL)getWhite:(CGFloat *)white alpha:(CGFloat *)alpha {
    return [self.qmui_rawColor getWhite:white alpha:alpha];
}

- (BOOL)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha {
    return [self.qmui_rawColor getHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    return [self.qmui_rawColor getRed:red green:green blue:blue alpha:alpha];
}

//- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
//    return [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject * _Nullable theme) {
//        return [self.themeProvider(manager, identifier, theme) colorWithAlphaComponent:alpha];
//    }];
//}
//
//- (CGFloat)alphaComponent {
//    return self.qmui_rawColor.qmui_alpha;
//}

//- (CGColorRef)CGColor {
//    CGColorRef colorRef = [UIColor colorWithCGColor:self.qmui_rawColor.CGColor].CGColor;
//    [(__bridge id)(colorRef) qmui_bindObject:self forKey:QMUICGColorOriginalColorBindKey];
//    return colorRef;
//}
//
//- (NSString *)colorSpaceName {
//    return [((QMUIThemeColor *)self.qmui_rawColor) colorSpaceName];
//}
//
- (id)copyWithZone:(NSZone *)zone {
    CustomColor *color = [[self class] allocWithZone:zone];
//    color.managerName = self.managerName;
//    color.themeProvider = self.themeProvider;
    color.count = self.count;
    color.colorBlk = self.colorBlk;
    return color;
}
// _isDynamic 是系统私有的方法，实现它有两个作用：
// 1. 在某些方法里（例如 UIView.backgroundColor），系统会判断当前的 color 是否为 _isDynamic，如果是，则返回 color 本身，如果否，则返回 color 的 CGColor，因此如果 QMUIThemeColor 不实现 _isDynamic 的话，`a.backgroundColor = b.backgroundColor`这种写法就会出错，因为从 `b.backgroundColor` 获取到的 color 已经是用 CGColor 重新创建的系统 UIColor，而非 QMUIThemeColor 了。
// 2. 当 iOS 13 系统设置里的 Dark Mode 发生切换时，系统会自动刷新带有 _isDynamic 方法的 color 对象，当然这个对 QMUI 而言作用不大，因为 QMUIThemeManager 有自己一套刷新逻辑，且很少有人会用 QMUIThemeColor 但却只依赖于 iOS 13 系统来刷新界面。
// 注意，QMUIThemeColor 是 UIColor 的直接子类，只有这种关系才能这样直接定义并重写，不能在 UIColor Category 里定义，否则可能污染 UIDynamicColor 里的 _isDynamic 的实现
- (BOOL)_isDynamic {
    return !!self.colorBlk;
}

//
//- (BOOL)isEqual:(id)object {
//    return self == object;// 例如在 UIView setTintColor: 时会比较两个 color 是否相等，如果相等，则不会触发 tintColor 的更新。由于 dynamicColor 实际的返回色值随时可能变化，所以即便当前的 qmui_rawColor 值相等，也不应该认为两个 dynamicColor 相等（有可能 themeProvider block 内的逻辑不一致，只是其中的某个条件下 return 的 qmui_rawColor 恰好相同而已），所以这里直接返回 NO。
//}
//
//- (NSUInteger)hash {
//    return (NSUInteger)self.themeProvider;// 与 UIDynamicProviderColor 相同
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, qmui_rawColor = %@", [super description], self.qmui_rawColor];
}

- (UIColor *)_highContrastDynamicColor {
    return self;
}

- (UIColor *)_resolvedColorWithTraitCollection:(UITraitCollection *)traitCollection {
    return self.qmui_rawColor;
}


@end
