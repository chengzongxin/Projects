//
//  TableViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "TableViewController.h"
#import "PageViewController.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PageTableView *tableView = [[PageTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:tableView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.subviews.firstObject.frame = self.view.bounds;
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
