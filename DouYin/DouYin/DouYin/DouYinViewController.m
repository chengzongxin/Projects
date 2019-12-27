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

static NSString *const PlayingCellID = @"PlayingCellID";
static NSString *const ReuseCellID = @"ReuseCellID";

@interface DouYinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray <DynamicListModelDataList *>*datas;

@property (assign, nonatomic) int currentIndex;

@property (assign, nonatomic) int currentPage;

@property (nonatomic, strong) LoadMoreControl                   *loadMore;

@property (strong, nonatomic) UIButton *btn;

@property (copy, nonatomic) NSString *currentCellID;

@end

@implementation DouYinViewController

/**
  reloadData时获取正在播放的Cell
 */
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
    self.currentCellID = PlayingCellID;
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

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(reloadClick) forControlEvents:UIControlEventTouchUpInside];
    _btn = btn;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(reloadClick)];
}

- (void)reloadClick{
    // 记录正在播放cell
    [self changeCurrentCellID];
    [self.tableView reloadData];
}

- (void)changeCurrentCellID{
    DouYinCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    self.currentCellID = cell.reuseIdentifier;
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
    // 正在播放时,刷新了cell
    
    static BOOL firstIn = YES;
    if (indexPath.row == self.currentIndex) {
        DouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:self.currentCellID];
        cell.model = self.datas[indexPath.row];
        if (firstIn) {
            firstIn = NO;
            [cell startDownloadBackgroundTask];
            [cell startDownloadForegroundTask];
            [cell autoPlay];
        }
        return cell;
    }
    
    
    DouYinCell *cell;
    
    if (indexPath.row % 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:PlayingCellID];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellID];
    }
    
    
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
        
        [self.btn setTitle:@(self.currentIndex).stringValue forState:UIControlStateNormal];
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
        //TODO: FIX: 如果没有播放,,就不会变成正在播放CELL,,可以在autoplay里设置标记
        [cell autoPlay];
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Private
- (void)loadDatas {
    NSString *url = @"http://service.matafy.com/community/dynamic/recommend/list";
    NSDictionary *para = @{@"dynamicType":@"VIDEO",@"page":@(1),@"size":@10};
    [NetworkRequest postWithUrl:url para:para dataHandle:^(NSArray <DynamicListModelDataList *> *data) {
        self.datas = data;
        [self.tableView reloadData];
        [self.loadMore endLoading];
        
//        DouYinCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        [cell startDownloadForegroundTask];
//        [cell autoPlay];
    }];
}

- (void)loadDatas:(int)page {
    NSString *url = @"http://service.matafy.com/community/dynamic/recommend/list";
    NSDictionary *para = @{@"dynamicType":@"VIDEO",@"page":@(page),@"size":@10};
    [NetworkRequest postWithUrl:url para:para dataHandle:^(NSArray <DynamicListModelDataList *> *data) {
        [self changeCurrentCellID];
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
        // Self-Sizing 关闭
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:DouYinCell.class forCellReuseIdentifier:PlayingCellID];
        [_tableView registerClass:DouYinCell.class forCellReuseIdentifier:ReuseCellID];
//        [_tableView registerClass:DouYinCell.class forCellReuseIdentifier:NSStringFromClass([DouYinCell class])];
//        _tableView.contentInset = UIEdgeInsetsZero;
        _loadMore = [[LoadMoreControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50) surplusCount:1];
        __weak __typeof(self) wself = self;
        
        [_loadMore setOnLoad:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [wself loadDatas:wself.currentPage++];
            });
        }];
        [_tableView addSubview:_loadMore];
    }
    return _tableView;
}

#pragma mark - Supperclass



#pragma mark - NSObject


@end
