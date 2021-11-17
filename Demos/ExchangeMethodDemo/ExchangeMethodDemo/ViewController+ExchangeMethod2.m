//
//  ViewController+ExchangeMethod2.m
//  ExchangeMethodDemo
//
//  Created by Joe.cheng on 2021/3/5.
//

#import "ViewController+ExchangeMethod2.h"
#import <objc/runtime.h>

@implementation ViewController (ExchangeMethod2)

+ (void)load{
    NSLog(@"RuntimeViewController load2");
    
    [self exchangeInstanceMethod1:@selector(viewWillAppear:) method2:@selector(wp_viewWillAppear:)];
    [self exchangeInstanceMethod1:@selector(viewWillDisappear:) method2:@selector(wp_viewWillDisappear2:)];
}

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}
- (void)wp_viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear_ExchangeMethod2");
    [self wp_viewWillAppear:animated];
}

- (void)wp_viewWillDisappear2:(BOOL)animated{
    NSLog(@"viewWillDisappear_ExchangeMethod2");
    [self wp_viewWillDisappear2:animated];
}

//直接覆盖
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear_ExchangeMethod2");
//}

+ (void)runtimeLog{
    NSLog(@"RuntimeViewController2");
}
@end
