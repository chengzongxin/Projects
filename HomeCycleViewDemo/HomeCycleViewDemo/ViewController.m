//
//  ViewController.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ViewController.h"
#import "HomeCycleView/HomeCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeCycleView *cycle = [[HomeCycleView alloc] initWithFrame:CGRectMake(0, 100, 375, 200)];
    cycle.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:cycle];
    
}


@end
