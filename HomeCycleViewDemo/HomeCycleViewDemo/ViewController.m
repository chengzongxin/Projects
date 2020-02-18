//
//  ViewController.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ViewController.h"
#import "HomeCycleView/HomeCycleView.h"
#import "HomeViewModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeCycleView *cycle = [[HomeCycleView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 210)];
    [self.view addSubview:cycle];
    
    [HomeViewModel request1:^(id _Nonnull data) {
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request2:^(id _Nonnull data) {
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request3:^(id _Nonnull data) {
        
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
}


@end
