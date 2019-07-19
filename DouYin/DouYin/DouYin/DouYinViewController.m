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
#import "Downloader.h"
#import "LoadMoreControl.h"
#import "Macro.h"

@interface DouYinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray <DynamicListModelDataList *>*datas;

@property (assign, nonatomic) int currentIndex;

@property (assign, nonatomic) int currentPage;

@property (nonatomic, strong) LoadMoreControl                   *loadMore;

@end

@implementation DouYinViewController

#pragma mark - Lifecycle (dealloc init viewDidLoad memoryWarning...)
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 停止下载
    [[Downloader sharedDownloader] cancelAllOperation];
    // 停止正在播放的cell
    DouYinCell *oldCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    [oldCell.playerView pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.currentPage = 1;
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
    
    [self loadDatas];
    
    [self addObserver];
}

- (void)addObserver{
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
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
    
    DouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DouYinCell class])];
    if (cell.tag == 888) {
        
        cell.tag = indexPath.row;
    }
    DDLogInfo(@"cellForRowAtIndexPath %zd,%@",cell.tag,indexPath.description);
    cell.model = self.datas[indexPath.row];
    [cell startDownloadBackgroundTask];
    return cell;
}


#pragma ScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.currentIndex + 1 >= self.datas.count) return;
        
        CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
        //UITableView禁止响应其他滑动手势
        scrollView.panGestureRecognizer.enabled = NO;
        if(translatedPoint.y < -50 ) {
            self.currentIndex ++;   //向下滑动索引递增
        }
        
        if(translatedPoint.y > 50 && self.currentIndex > 0) {
            self.currentIndex --;   //向上滑动索引递减
        }
        
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                //                                [originCell pause];
                                //UITableView滑动到指定cell
                                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                            } completion:^(BOOL finished) {
                                //UITableView可以响应其他滑动手势
                                scrollView.panGestureRecognizer.enabled = YES;
                            }];
    });
}

#pragma KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //观察currentIndex变化
    if ([keyPath isEqualToString:@"currentIndex"]) {
        int oldIndex = [change[NSKeyValueChangeOldKey] intValue];
        int newIndex = [change[NSKeyValueChangeNewKey] intValue];
        // 停止旧的播放
        DouYinCell *oldCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:oldIndex inSection:0]];
        [oldCell.playerView seekToBegin];
        [oldCell.playerView pause];
        //获取当前显示的cell
        DouYinCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:newIndex inSection:0]];
        [cell startDownloadForegroundTask];
        [cell autoPlay];
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Private
- (void)loadDatas {
    NSString *url = @"http://service.matafy.com/community/dynamic/recommend/list";
    NSDictionary *para = @{@"dynamicType":@"VIDEO",@"page":@(1),@"size":@5};
    [NetworkRequest postWithUrl:url para:para dataHandle:^(NSArray <DynamicListModelDataList *> *data) {
        self.datas = data;
        [self.tableView reloadData];
        [self.loadMore endLoading];
        
        DouYinCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell startDownloadForegroundTask];
        [cell autoPlay];
        
    }];
}

- (void)loadDatas:(int)page {
    NSString *url = @"http://service.matafy.com/community/dynamic/recommend/list";
    NSDictionary *para = @{@"dynamicType":@"VIDEO",@"page":@(page),@"size":@5};
    [NetworkRequest postWithUrl:url para:para dataHandle:^(NSArray <DynamicListModelDataList *> *data) {
        self.datas = [self.datas arrayByAddingObjectsFromArray:data];
        [self.tableView reloadData];
        [self.loadMore endLoading];
        
    }];
}


#pragma mark - Getters and Setters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:DouYinCell.class forCellReuseIdentifier:NSStringFromClass([DouYinCell class])];
//        _tableView.contentInset = UIEdgeInsetsZero;
        _loadMore = [[LoadMoreControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50) surplusCount:1];
        __weak __typeof(self) wself = self;
        
        [_loadMore setOnLoad:^{
            [wself loadDatas:wself.currentPage++];
        }];
        [_tableView addSubview:_loadMore];
    }
    return _tableView;
}

#pragma mark - Supperclass



#pragma mark - NSObject


@end
