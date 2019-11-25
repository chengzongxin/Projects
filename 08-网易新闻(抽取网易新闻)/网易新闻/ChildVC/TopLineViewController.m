
//  TopLineViewController.m
//  网易新闻
//
//  Created by xiaomage on 16/3/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "TopLineViewController.h"
#import "OrderTableView.h"

@interface TopLineViewController ()

@end

@implementation TopLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    OrderTableView *table = [[OrderTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:table];
}


@end
