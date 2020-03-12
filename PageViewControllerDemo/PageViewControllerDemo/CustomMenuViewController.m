//
//  CustomMenuViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/3/12.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "CustomMenuViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "NormalViewController.h"

@interface CustomMenuViewController ()
@property (strong, nonatomic) UIView *menuView;
@end

@implementation CustomMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PageVC-CustomMenu";
    
    [self.view addSubview:self.menuView];
}

- (void)tabClick:(UIButton *)btn{
    NSLog(@"%s",__FUNCTION__);
}

- (NSArray<UIViewController *> *)pageChildViewControllers{
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"1232",@"13"];
    for (int i = 0; i < titleArr.count; i ++) {
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


#pragma mark - Getter
- (UIView *)menuView{
    if (!_menuView) {
        CGFloat y = self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height + 15;
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(15, y, self.view.bounds.size.width - 15*2, 48)];
        // btn1
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, _menuView.bounds.size.width/2, _menuView.bounds.size.height);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"coin_ls_btn_01"] forState:UIControlStateNormal];
        //        [btn1 setBackgroundImage:[UIImage imageNamed:@"coin_ls_btn_02"] forState:UIControlStateSelected];
        [btn1 addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"1231" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:51/255.0 green:101/255.0 blue:145/255.0 alpha:1.0] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        btn1.selected = NO;
        btn1.tag = 1;
        // btn2
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(_menuView.bounds.size.width/2, 0, _menuView.bounds.size.width/2, _menuView.bounds.size.height);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"coin_ls_btn_02"] forState:UIControlStateNormal];
        //        [btn2 setBackgroundImage:[UIImage imageNamed:@"coin_ls_btn_02"] forState:UIControlStateSelected];
        [btn2 addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"1345" forState:UIControlStateNormal];
        [btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        btn2.selected = YES;
        btn2.tag = 2;
        
        [_menuView addSubview:btn1];
        [_menuView addSubview:btn2];
    }
    return _menuView;
}

@end
