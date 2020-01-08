//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
}


- (void)setupAllChildViewController{
    NSArray *arr = @[@"1232",@"13",@"12333",@"1233333",@"123",@"1233333",@"2",@"5",@"232323232",@"123",@"123",@"123",@"123",@"123",@"123"];
    for (int i = 0; i < 10; i ++) {
        UIViewController *vc = [[UIViewController alloc] init];
//        vc.title = @(i).stringValue;
        vc.title = arr[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self addChildViewController:vc];
    }
    
}

- (UIView *)setupHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    view.backgroundColor = UIColor.orangeColor;
    [view addSubview:[UISwitch new]];
    return view;
}

@end
