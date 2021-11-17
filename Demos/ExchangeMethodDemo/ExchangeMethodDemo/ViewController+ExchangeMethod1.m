//
//  ViewController+ExchangeMethod1.m
//  ExchangeMethodDemo
//
//  Created by Joe.cheng on 2021/3/5.
//

#import "ViewController+ExchangeMethod1.h"
#import <objc/runtime.h>

@implementation ViewController (ExchangeMethod1)

+ (void)load{
    NSLog(@"RuntimeViewController load1");
    [self exchangeInstanceMethod1:@selector(viewWillAppear:) method2:@selector(wp_viewWillAppear1:)];
    [self exchangeInstanceMethod1:@selector(viewWillDisappear:) method2:@selector(wp_viewWillDisappear1:)];
}

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}
- (void)wp_viewWillAppear1:(BOOL)animated{
    NSLog(@"viewWillAppear_ExchangeMethod1");
    [self wp_viewWillAppear1:animated];
}

- (void)wp_viewWillDisappear1:(BOOL)animated{
    NSLog(@"viewWillDisappear_ExchangeMethod1");
    [self wp_viewWillDisappear1:animated];
}
//直接覆盖
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear_ExchangeMethod1");
//}

+ (void)runtimeLog{
    NSLog(@"RuntimeViewController1");
}

@end
