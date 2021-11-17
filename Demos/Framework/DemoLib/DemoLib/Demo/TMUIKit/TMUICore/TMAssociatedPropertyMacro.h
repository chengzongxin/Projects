//
//  TMAssociatedPropertyMacro.h
//  Pods
//
//  Created by nigel.ning on 2020/7/23.
//

#ifndef TMAssociatedPropertyMacro_h
#define TMAssociatedPropertyMacro_h

#import "TMUIWeakObjectContainer.h"
#import <objc/runtime.h>

//针对在类型里添加属性的相关便捷宏定义

#pragma mark -  关联的属性声明

///strong修饰的OC类型,会指定setter方法格式为set__propertyName,外部用.操作符赋值即可
#define TMAssociatedPropertyStrongType(Type, propertyName) \
@property (nonatomic, strong, setter=set__##propertyName:, nullable)Type * propertyName;

///weak修饰的OC类型,会指定setter方法格式为set__propertyName,外部用.操作符赋值即可
#define TMAssociatedPropertyWeakType(Type, propertyName) \
@property (nonatomic, weak, setter=set__##propertyName:, nullable)Type * propertyName;

///assign修饰的基础数字类型,会指定setter方法格式为set__propertyName,外部用.操作符赋值即可
#define TMAssociatedPropertyAssignType(Type, propertyName) \
@property (nonatomic, assign, setter=set__##propertyName:)Type propertyName;

///assign修饰的结构体类型的数据类型，比如 CGPoint、CGSize、CGRect等，对应setter, 会指定setter方法格式为set__propertyName,外部用.操作符赋值即可
#define TMAssociatedPropertyAssignStructType(StructType, propertyName) \
@property (nonatomic, assign, setter=set__##propertyName:)StructType propertyName;

#pragma mark -  关联的属性setter\getter方法实现

#define TMAssociatedPropertyStrongTypeSetterGetter(Type, propertyName) \
@dynamic  propertyName; \
- (void)set__##propertyName:(Type *)propertyName \
{ \
    _tmui_setAssociatedStrongObj(self, @selector(propertyName), propertyName);  \
\
} \
  \
- (Type *)propertyName \
{   \
    return _tmui_associatedStrongObj(self, @selector(propertyName));    \
}   \


#define TMAssociatedPropertyWeakTypeSetterGetter(Type, propertyName) \
@dynamic  propertyName; \
- (void)set__##propertyName:(Type *)propertyName \
{ \
    _tmui_setAssociatedWeakObj(self, @selector(propertyName), propertyName);  \
\
} \
  \
- (Type *)propertyName \
{   \
    return _tmui_associatedWeakObj(self, @selector(propertyName));    \
}   \


#define TMAssociatedPropertyAssignTypeSetterGetter(Type, propertyName, numberToAssignValueMethod) \
@dynamic  propertyName; \
- (void)set__##propertyName:(Type)propertyName \
{ \
    _tmui_setAssociatedStrongObj(self, @selector(propertyName), @(propertyName));  \
\
} \
  \
- (Type)propertyName \
{   \
    NSNumber *_##Type##_##propertyName##_number = _tmui_associatedStrongObj(self, @selector(propertyName));    \
    return [_##Type##_##propertyName##_number numberToAssignValueMethod]; \
} \

#define TMAssociatedPropertyAssignStructTypeSetterGetter(Type, propertyName) \
@dynamic  propertyName; \
- (void)set__##propertyName:(Type)propertyName \
{ \
    NSValue *_##Type##_##propertyName##_value = [NSValue valueWith##Type:propertyName]; \
    _tmui_setAssociatedStrongObj(self, @selector(propertyName), _##Type##_##propertyName##_value);  \
\
} \
  \
- (Type)propertyName \
{   \
    NSValue *_##Type##_##propertyName_value = _tmui_associatedStrongObj(self, @selector(propertyName));    \
    return [_##Type##_##propertyName_value Type##Value]; \
} \


#pragma mark - 辅助方法

#pragma mark - strong或assign属性setter&getter的辅助方法
NS_INLINE void _tmui_setAssociatedStrongObj(id _Nonnull self, SEL _Nonnull sel, id _Nullable obj) {
    objc_setAssociatedObject(self, sel, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};

NS_INLINE id _Nullable _tmui_associatedStrongObj(id _Nonnull self, SEL _Nonnull sel) {
    id obj = objc_getAssociatedObject(self, sel);
    return obj;
};

#pragma mark - weak属性setter&getter的辅助方法
NS_INLINE void _tmui_setAssociatedWeakObj(id _Nonnull self, SEL _Nonnull sel, id _Nullable obj) {
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, sel);
    if (obj) {
        if (!weakObjContainer) {
            weakObjContainer = [TMUIWeakObjectContainer containerWithObject:obj];
        }
        weakObjContainer.object = obj;
    }else {
        weakObjContainer = nil;
    }
    
    objc_setAssociatedObject(self, sel, weakObjContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
};

NS_INLINE id _Nullable _tmui_associatedWeakObj(id _Nonnull self, SEL _Nonnull sel) {
    TMUIWeakObjectContainer *weakObjContainer = objc_getAssociatedObject(self, sel);
    if (weakObjContainer.object) {
        return weakObjContainer.object;
    }
    return nil;
};

#endif /* TMAssociatedPropertyMacro_h */
