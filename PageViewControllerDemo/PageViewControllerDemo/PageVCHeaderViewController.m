//
//  OneViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageVCHeaderViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
@interface PageVCHeaderViewController ()

@end

@implementation PageVCHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageVC-Header";
}


- (void)setupAllChildViewController{
    NSArray *arr = @[@"1232",@"13",@"12333",@"1233333",@"123",@"1233333",@"2",@"5",@"232323232",@"123",@"123",@"123",@"123",@"123",@"123"];
    for (int i = 0; i < 10; i ++) {
        UIViewController *vc = (i % 2) ? CollectionViewController.new : TableViewController.new;
        //        vc.title = @(i).stringValue;
        vc.title = arr[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self addChildViewController:vc];
    }
    
}

- (UIView *)setupHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    view.backgroundColor = UIColor.orangeColor;
    [view addSubview:[[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)]];
    return view;
}
@end
