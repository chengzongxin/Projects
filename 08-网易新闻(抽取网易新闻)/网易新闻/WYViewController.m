//
//  WYViewController.m
//  网易新闻
//
//  Created by xiaomage on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WYViewController.h"
#import "TopLineViewController.h"
#import "HotViewController.h"
#import "ScoietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"
#import "VideoViewController.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 添加所有子控制器
    [self setupAllChildViewController];
}

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 头条
    TopLineViewController *vc1 = [[TopLineViewController alloc] init];
    vc1.title = @"头条";
    [self addChildViewController:vc1];
    
    // 热点
    HotViewController *vc2 = [[HotViewController alloc] init];
    vc2.title = @"热点";
    [self addChildViewController:vc2];
    
    // 视频
//    VideoViewController *vc3 = [[VideoViewController alloc] init];
//    vc3.title = @"视频";
//    [self addChildViewController:vc3];
//    
//    // 社会
//    ScoietyViewController *vc4 = [[ScoietyViewController alloc] init];
//    vc4.title = @"社会";
//    [self addChildViewController:vc4];
    
    // 订阅
    ReaderViewController *vc5 = [[ReaderViewController alloc] init];
    vc5.title = @"订阅";
    [self addChildViewController:vc5];
    
    // 科技
    ScienceViewController *vc6 = [[ScienceViewController alloc] init];
    vc6.title = @"科技";
    [self addChildViewController:vc6];
}


@end
