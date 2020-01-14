//
//  ChargeHistoryViewController.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/1/14.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ChargeHistoryViewController.h"
#import "ChargeHistoryCell.h"

@interface ChargeHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *menuView;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ChargeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:249/255.0 alpha:1.0];
    self.title = @"历史记录";
    
    [self.view addSubview:self.menuView];
    
    [self.view addSubview:self.tableView];
}



- (void)tabClick:(UIButton *)btn{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChargeHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChargeHistoryCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChargeDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
        [btn1 setTitle:@"提币记录" forState:UIControlStateNormal];
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
        [btn2 setTitle:@"充币记录" forState:UIControlStateNormal];
        [btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        btn2.selected = YES;
        btn2.tag = 2;
        
        [_menuView addSubview:btn1];
        [_menuView addSubview:btn2];
    }
    return _menuView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGFloat y = CGRectGetMaxY(self.menuView.frame) + 23;
        CGRect frame = CGRectMake(15, y, self.view.bounds.size.width - 15*2, self.view.bounds.size.height - y);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _tableView.layer.cornerRadius = 4;
        _tableView.layer.masksToBounds = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 18, 0, 18);
        _tableView.separatorColor = [UIColor colorWithRed:246/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChargeHistoryCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChargeHistoryCell class])];
    }
    return _tableView;
}


@end
