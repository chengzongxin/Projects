//
//  SwizzleExampleClass.m
//  SwizzleDemo
//
//  Created by Joe on 2019/9/19.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "SwizzleExampleClass.h"
#import <objc/runtime.h>

struct objc_method_des {
    char * method_name;
    char *method_types;
    IMP method_imp;
};


static IMP __original_Method_Imp;
int _replacement_Method(id self, SEL _cmd)
{
    assert([NSStringFromSelector(_cmd) isEqualToString:@"originalMethod"]);
    //code
    int returnValue = ((int(*)(id,SEL))__original_Method_Imp)(self, _cmd);
    return returnValue + 1;
}

@implementation SwizzleExampleClass

- (void) swizzleExample //call me to swizzle
{
    Method m = class_getInstanceMethod([self class],@selector(originalMethod));
    
    struct objc_method_des *method_struct = (struct objc_method_des *)m;
    NSLog(@"%s",method_struct->method_name);
    NSLog(@"%s",method_struct->method_types);
    NSLog(@"%p",method_struct->method_imp);
    NSLog(@"----------------------------");
    
    __original_Method_Imp = method_setImplementation(m,(IMP)_replacement_Method);
    
//    struct objc_method_des *method_struct = (struct objc_method_des *)m;
    NSLog(@"%s",method_struct->method_name);
    NSLog(@"%s",method_struct->method_types);
    NSLog(@"%p",method_struct->method_imp);
}

- (int) originalMethod
{
    //code
    assert([NSStringFromSelector(_cmd) isEqualToString:@"originalMethod"]);
    return 1;
}

@end
