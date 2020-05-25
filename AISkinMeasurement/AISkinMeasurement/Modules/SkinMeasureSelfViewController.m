//
//  SkinMeasureSelfViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMeasureSelfViewController.h"
#import "SkinMesureRecordCell.h"

@interface SkinMeasureSelfViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SkinMeasureSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SkinMesureRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkinMesureRecordCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Getter TableView
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 64;
        // UITableViewStyleGrouped headerView占据35高度
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        // 自适应内容边距
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        // 隐藏下面多出来的cell
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkinMesureRecordCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SkinMesureRecordCell class])];
    }
    return _tableView;
}

@end
