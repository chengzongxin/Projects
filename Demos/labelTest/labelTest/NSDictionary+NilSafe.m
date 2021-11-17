//
//  NSDictionary+NilSafe.m
//  HouseKeeper
//
//  Created by kevin.huang on 2018/3/13.
//  Copyright © 2018年 binxun. All rights reserved.
//
#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"


@implementation NSObject (Swizzling)

+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) gl_swizzleMethod:origSel withMethod:altSel];
}

@end

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(gl_initWithObjects:forKeys:count:)];
        [self gl_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
//        #ifdef DEBUG
//        #else
            if (!key || !obj) {
                continue;
            }
//        #endif
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        #ifdef DEBUG
        #else
            if (!key || !obj) {
                continue;
            }
        #endif
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (id)safeObjectForKey:(id)key {
    if (!key || ![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [self objectForKey:key];
    return obj;
}

- (NSString *)safeStringForKey:(id)key {
    
    if (!key || ![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSString *string = [self objectForKey:key];
    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        string = nil;
    }
    return string;
}


- (NSArray *)safeArrayForKey:(id)key {
    if (!key || ![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *array = [self objectForKey:key];
    if (![array isKindOfClass:[NSArray class]]) {
        array = nil;
    }
    return array;
}

- (NSDictionary *)safeDictionaryForKey:(id)key {
    if (!key|| ![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *dictionary = [self objectForKey:key];
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        dictionary = nil;
    }
    return dictionary;
}


@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class gl_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(gl_setObject:forKey:)];
        [class gl_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}

@end


