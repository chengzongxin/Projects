//
//  WKWebView+Cache.m
//  WebViewDemo
//
//  Created by Joe on 2019/9/27.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "WKWebView+Cache.h"
#import "CustomURLSchemeHandler.h"
#import <objc/runtime.h>
//struct objc_method_des {
//    char * method_name;
//    char *method_types;
//    IMP method_imp;
//};

@implementation WKWebView (Cache)


#pragma mark - SWIZZ ORIGIN METHOD
static IMP _originalMethodImp = nil;
static NSString *_originScheme = nil;

+ (void)load{
    Class aClass = [self class];
    
    SEL originalSelector = @selector(initWithFrame:configuration:);
    
    SEL swizzledSelector = @selector(cacheWithFrame:configuration:);
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(aClass,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    
    if(didAddMethod) {
        class_replaceMethod(aClass,swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 替换原有方法-initWithFrame:configuration:
- (instancetype)cacheWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    NSLog(@"%s",__FUNCTION__);
    //设置URLSchemeHandler来处理特定URLScheme的请求，URLSchemeHandler需要实现WKURLSchemeHandler协议
    //本例中WKWebView将把URLScheme为customScheme的请求交由CustomURLSchemeHandler类的实例处理
    [configuration setURLSchemeHandler:[CustomURLSchemeHandler new] forURLScheme:customscheme];  // 这句代码必须在创建webview之前设置
    return [self cacheWithFrame:frame configuration:configuration];
}

id _swizzleLoadRequestMethod(id self,SEL _cmd,NSURLRequest *request)
{
    assert([NSStringFromSelector(_cmd) isEqualToString:NSStringFromSelector(@selector(loadRequest:))]);
    
    if ([self cacheEnable]) {
        _originScheme = request.URL.scheme;
        NSString *customUrlString = [request.URL.absoluteString stringByReplacingOccurrencesOfString:_originScheme withString:customscheme];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:customUrlString]];
    }
    
    id returnValue = ((id(*)(id,SEL,NSURLRequest*))_originalMethodImp)(self, _cmd,request);
    return returnValue;
}

- (void)swizzLoadRequest{
    
    if (_originalMethodImp) {
        // 已经替换了方法
        return;
    }
    
    Method method = class_getInstanceMethod(self.class, @selector(loadRequest:));
    
//    struct objc_method_des *method_struct = (struct objc_method_des *)method;
    
//    NSLog(@"%s",method_struct->method_name);
//    NSLog(@"%s",method_struct->method_types);
//    NSLog(@"%p",method_struct->method_imp);
//    NSLog(@"----------------------------");
    
    IMP swizzleImp = (IMP)_swizzleLoadRequestMethod;
    
    
    _originalMethodImp = method_setImplementation(method,swizzleImp);
    
    
//    NSLog(@"%s",method_struct->method_name);
//    NSLog(@"%s",method_struct->method_types);
//    NSLog(@"%p",method_struct->method_imp);
//    NSLog(@"----------------------------");
}


#pragma mark - Public Method

+ (void)clearCache{
    //allWebsiteDataTypes清除所有缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
    // 清除缓存数据
    [[CustomURLSchemeHandler new] clearCache];
}


#pragma mark - Setter & Getter
- (NSString *)originScheme{
    return _originScheme;
}

- (BOOL)cacheEnable{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCacheEnable:(BOOL)cacheEnable{
    objc_setAssociatedObject(self, @selector(cacheEnable), @(cacheEnable), OBJC_ASSOCIATION_ASSIGN);
    // 替换loadrequest方法
    
    if (cacheEnable) {
        [self swizzLoadRequest];
    }
}

- (float)maxDiskCache{
    float maxCache = [objc_getAssociatedObject(self, _cmd) floatValue];
    if (maxCache == 0) {
        maxCache = 1024;
    }
    return maxCache;
}

- (void)setMaxDiskCache:(float)maxDiskCache{
    objc_setAssociatedObject(self, @selector(maxDiskCache), @(maxDiskCache), OBJC_ASSOCIATION_ASSIGN);
}

@end
