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
        cycle.diffPriceData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request2:^(id _Nonnull data) {
        cycle.hotSymbolData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [HomeViewModel request3:^(id _Nonnull data) {
        cycle.exponentData = data;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    [cycle didSelectModel:^(DiffPriceModelData * _Nonnull model) {
        NSLog(@"%@",model.symbolAndReference);
    } hotSymbolBlock:^(HotSymbolModelData * _Nonnull model) {
        NSLog(@"%@",model.symbol);
    } exponentBlock:^(ExponentModelData * _Nonnull model) {
        NSLog(@"%@",model.symbolName);
    }];
    
    
}


@end
