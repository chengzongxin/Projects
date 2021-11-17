//
//  TableViewController.m
//  Demo
//
//  Created by Joe.cheng on 2020/11/27.
//

#import "TableViewController.h"

@interface TableViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation TableViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    NSLog(@"%@ %s",self.class,__func__);
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"%@ %s",self.class,__func__);
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//    NSLog(@"%@ %s",self.class,__func__);
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//
//    NSLog(@"%@ %s",self.class,__func__);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@ %s",self.class,__func__);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    tableView.rowHeight = 88;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%@",indexPath.row,NSStringFromClass(self.class)];
    return cell;;
}

@end
