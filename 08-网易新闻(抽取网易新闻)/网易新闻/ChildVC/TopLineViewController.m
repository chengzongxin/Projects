
//  TopLineViewController.m
//  网易新闻
//
//  Created by xiaomage on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "TopLineViewController.h"
#import "RecommendTableView.h"

@interface TopLineViewController ()

@end

@implementation TopLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;

    RecommendTableView *table = [[RecommendTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:table];
}


@end
