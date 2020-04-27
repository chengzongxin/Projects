//
//  ViewController.m
//  RefreshControl
//
//  Created by Joe on 2020/4/23.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+RefreshController.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 50;
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    
    [self.tableView addRefreshWithHeaderBlock:^{
        NSLog(@"%s",__FUNCTION__);
        [self.tableView headerStopRefresh];
        [self.tableView resetNoMoreData];
    } footerBlock:^{
        self.count += 20;
        NSLog(@"%d",self.count);
        [self.tableView footerStopRefresh];
            [self.tableView reloadData];
        
        if (self.count > 200) {
            [self.tableView noticeNoreMoreData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.textLabel.text = @(indexPath.item).stringValue;
    return cell;
}


@end
