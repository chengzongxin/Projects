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
    
//    NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:@1,@2,@3, nil];
    
    [HomeViewModel request1:^(id _Nonnull data) {
//        [dataArray replaceObjectAtIndex:0 withObject:data];
        cycle.diffPriceData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request2:^(id _Nonnull data) {
//        [dataArray replaceObjectAtIndex:0 withObject:data];
        cycle.hotSymbolData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request3:^(id _Nonnull data) {
//        [dataArray replaceObjectAtIndex:0 withObject:data];
        cycle.exponentData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        cycle.datas = dataArray;
//    });
    
    
}


@end
