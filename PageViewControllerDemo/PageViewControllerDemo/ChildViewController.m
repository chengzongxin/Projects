//
//  ChildViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/8.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ChildViewController.h"
#import "PageTableView.h"

@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PageTableView *tableView = [[PageTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = tableView;
    tableView.dataSource = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

@end
