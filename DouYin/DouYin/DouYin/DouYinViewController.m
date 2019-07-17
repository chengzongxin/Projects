//
//  DouYinViewController.m
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "DouYinViewController.h"
#import "AVPlayerView.h"
#import "DouYinCell.h"
#import "NetworkRequest.h"

@interface DouYinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *datas;

@end

@implementation DouYinViewController

#pragma mark - Lifecycle (dealloc init viewDidLoad memoryWarning...)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *url = @"https://video1.matafy.com/pipixia/201906/pipixia_6704993604315650317.mp4";
//
//    AVPlayerView *player = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:player];
//    [player setPlayerUrl:url];
    
    [self.view addSubview:self.tableView];
    
    [self loadDatas];
}



#pragma mark - Public




#pragma mark - Event Respone

#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath.description);
    DouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DouYinCell class])];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.model = self.datas[indexPath.row];
    [cell startDownloadBackgroundTask];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}

#pragma mark - Private
- (void)loadDatas {
    NSString *url = @"http://service.matafy.com/community/dynamic/recommend/list";
    NSDictionary *para = @{@"dynamicType":@"VIDEO",@"page":@1,@"size":@1};
    [NetworkRequest postWithUrl:url para:para dataHandle:^(NSArray <DynamicListModelDataList *> *data) {
        self.datas = data;
        [self.tableView reloadData];
    }];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.pagingEnabled = true;
        [_tableView registerClass:DouYinCell.class forCellReuseIdentifier:NSStringFromClass([DouYinCell class])];
    }
    return _tableView;
}

#pragma mark - Supperclass



#pragma mark - NSObject


@end
