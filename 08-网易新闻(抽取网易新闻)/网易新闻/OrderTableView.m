//
//  OrderTableView.m
//  网易新闻
//
//  Created by Joe on 2019/11/25.
//  Copyright © 2019 小码哥. All rights reserved.
//


#import "OrderTableView.h"


@interface OrderTableView () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    
    return cell;
}


@end
