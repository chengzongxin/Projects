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
#import "NormalViewController.h"

@interface PageVCHeaderViewController ()

@end

@implementation PageVCHeaderViewController

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageVC-Header";
}

#pragma mark - Delegate
- (NSArray<UIViewController *> *)pageChildViewControllers{
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"1232",@"13",@"12333",@"1233333",@"123",@"1233333",@"2",@"5",@"232323232",@"123",@"123",@"123",@"123",@"123",@"123"];
    for (int i = 0; i < 10; i ++) {
        int num = i % 3;
        UIViewController *vc;
        if (num == 0) {
            vc = CollectionViewController.new;
        }else if (num == 1) {
            vc = TableViewController.new;
        }else{
            vc = NormalViewController.new;
        }
        //        vc.title = @(i).stringValue;
        vc.title = titleArr[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [vcArr addObject:vc];
    }
    return vcArr;
}

- (UIView *)pageHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    view.backgroundColor = UIColor.greenColor;
    [view addSubview:[[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)]];
    return view;
}


//- (NSArray<NSString *> *)pageTitles{
//    return @[@"1",@"12",@"123",@"1234",@"12345",@"123456",@"1234567",@"12345678",@"123456789",@"12345678910"];
//}

- (void)pageViewController:(PageViewController *)pageViewController didScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)pageViewController:(PageViewController *)pageViewController didSelectWithIndex:(NSInteger)index{
    NSLog(@"%zd",index);
}

@end
