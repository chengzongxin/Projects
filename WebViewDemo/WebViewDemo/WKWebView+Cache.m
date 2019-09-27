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
static BOOL _enable = false;

+ (void)load{
    Class aClass = [self class];
    
    SEL initCfg = @selector(initWithFrame:configuration:);
    
    SEL cacheCfg = @selector(cacheWithFrame:configuration:);
    
    Method originalMethod = class_getInstanceMethod(aClass, initCfg);
    
    Method swizzledMethod = class_getInstanceMethod(aClass, cacheCfg);
    
    BOOL didAddMethod = class_addMethod(aClass,initCfg,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    
    if(didAddMethod) {
        class_replaceMethod(aClass,cacheCfg,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
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

id _swizzleMethod(id self,SEL _cmd,NSURLRequest *request)
{
    assert([NSStringFromSelector(_cmd) isEqualToString:NSStringFromSelector(@selector(loadRequest:))]);
    //code
    id returnValue = ((id(*)(id,SEL,NSURLRequest*))_originalMethodImp)(self, _cmd,request);
    return returnValue;
}


id _swizzleLoadRequestMethod(id self,SEL _cmd,NSURLRequest *request)
{
    assert([NSStringFromSelector(_cmd) isEqualToString:NSStringFromSelector(@selector(loadRequest:))]);
    
    if (_enable) {
        _originScheme = request.URL.scheme;
        NSString *customUrlString = [request.URL.absoluteString stringByReplacingOccurrencesOfString:_originScheme withString:customscheme];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:customUrlString]];
    }
    
    id returnValue = ((id(*)(id,SEL,NSURLRequest*))_originalMethodImp)(self, _cmd,request);
    return returnValue;
}

- (void)cacheEnable{
    _enable = true;
    
    if (_originalMethodImp) {
        return;
    }
    
    Method method = class_getInstanceMethod(self.class, @selector(loadRequest:));
    
//    struct objc_method_des *method_struct = (struct objc_method_des *)method;
    
//    NSLog(@"%s",method_struct->method_name);
//    NSLog(@"%s",method_struct->method_types);
//    NSLog(@"%p",method_struct->method_imp);
//    NSLog(@"----------------------------");
    
    IMP swizzleImp = (IMP)_swizzleMethod;
    
    
    _originalMethodImp = method_setImplementation(method,swizzleImp);
    
    
//    NSLog(@"%s",method_struct->method_name);
//    NSLog(@"%s",method_struct->method_types);
//    NSLog(@"%p",method_struct->method_imp);
//    NSLog(@"----------------------------");
}

//- (WKNavigation *)loadRequest:(NSURLRequest *)request{
//    return [self loadRequest:request];
//}

@end
