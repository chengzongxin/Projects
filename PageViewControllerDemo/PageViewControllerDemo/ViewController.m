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
    
    for (int i = 0; i < 10; i ++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = @(i).stringValue;
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
