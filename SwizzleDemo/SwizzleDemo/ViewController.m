//
//  ViewController.m
//  SwizzleDemo
//
//  Created by Joe on 2019/9/19.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import "SwizzleExampleClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SwizzleExampleClass* example = [[SwizzleExampleClass alloc] init];
    int originalReturn = [example originalMethod];
    [example swizzleExample]; // 两次交换引起循环调用crash
    int swizzledReturn = [example originalMethod];
    assert(originalReturn == 1); //true
    assert(swizzledReturn == 2); //true
    NSLog(@"originalReturn = %d",originalReturn);
    NSLog(@"swizzledReturn = %d",swizzledReturn);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SwizzleExampleClass* example = [[SwizzleExampleClass alloc] init];
    int originalReturn = [example originalMethod];
    NSLog(@"originalReturn = %d",originalReturn);
}

@end
