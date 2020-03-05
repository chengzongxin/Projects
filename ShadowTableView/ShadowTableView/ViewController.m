//
//  ViewController.m
//  shadow
//
//  Created by wang on 2019/6/19.
//  Copyright © 2019 wang. All rights reserved.
//

#import "ViewController.h"
#import "ShadowSectionCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShadowSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ShadowSectionCell.class) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.sectionHeaderHeight = 15;
        _tableview.sectionFooterHeight = 0;
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass(ShadowSectionCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ShadowSectionCell.class)];
    }
    return _tableview;
}

@end
