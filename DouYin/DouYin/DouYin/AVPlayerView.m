//
//  AVPlayerView.m
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "AVPlayerView.h"
#import "Downloader.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CommonCrypto/CommonCrypto.h>
#import "StorageManager.h"

@interface AVPlayerView ()<AVAssetResourceLoaderDelegate>

@property (nonatomic ,strong) NSURL                *sourceURL;              //视频路径
@property (nonatomic ,strong) NSString             *sourceScheme;           //路径Scheme
@property (nonatomic ,strong) AVURLAsset           *urlAsset;               //视频资源
@property (nonatomic ,strong) AVPlayerItem         *playerItem;             //视频资源载体
@property (nonatomic ,strong) AVPlayer             *player;                 //视频播放器
@property (nonatomic ,strong) AVPlayerLayer        *playerLayer;            //视频播放器图形化载体
@property (nonatomic ,strong) id                   timeObserver;            //视频播放器周期性调用的观察者
@property (nonatomic, strong) NSMutableArray       *pendingRequests;        //存储AVAssetResourceLoadingRequest的数组

@property (strong, nonatomic) WebDownloadOperation *downloadOperation;      //下载操作
@property (nonatomic, strong) NSMutableData        *data;                   //视频缓冲数据
@property (nonatomic, copy) NSString               *mimeType;               //资源格式
@property (nonatomic, assign) long long            expectedContentLength;   //资源大小

@end

@implementation AVPlayerView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化存储AVAssetResourceLoadingRequest的数组
        _pendingRequests = [NSMutableArray array];
        //初始化播放器
        _player = [AVPlayer new];
        //添加视频播放器图形化载体AVPlayerLayer
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.backgroundColor = UIColor.blackColor.CGColor;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:_playerLayer];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //禁止隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _playerLayer.frame = self.layer.bounds;
    [CATransaction commit];
}

#pragma mark - Public

- (void)play{
    [_player play];
}

- (void)pause{
    [_player pause];
}

- (void)updatePlayerState{
    if(_player.rate == 0) {
        [self play];
    }else {
        [self pause];
    }
}

- (void)seekToBegin {
    [_player seekToTime:kCMTimeZero];
}

- (void)replay{
    [_player seekToTime:kCMTimeZero];
    [_player play];
}

- (void)seekToProgress:(long)progress{
//        DDLogInfo(@"url:%@,data:%lu",URL.absoluteString,(unsigned long)self.data.length);
    if (progress < 0) {
        return;
    }
    if (self.player.status == AVPlayerItemStatusReadyToPlay) {
        __weak typeof(self) blockSelf = self;
    //    [_avPlayerItem cancelPendingSeeks];
        [self.player.currentItem cancelPendingSeeks];
        [self.player pause];
        [self.player seekToTime:CMTimeMakeWithSeconds(progress, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
            [blockSelf.player play];
        }];
    }
}

- (void)setPlayerUrl:(NSString *)url {
    //播放路径
    self.sourceURL = [NSURL URLWithString:url];
    //获取路径schema
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self.sourceURL resolvingAgainstBaseURL:NO];
    self.sourceScheme = components.scheme;
    // 查找缓存
    NSString *filePath = [[StorageManager manager] queryDataForKey:url extension:@"mp4"];
    if (filePath) {
        self.sourceURL = [NSURL fileURLWithPath:filePath];
        DDLogInfo(@"%@ file has download",filePath);
    }else{
        // 替换streaming
        self.sourceURL = [self urlScheme:@"streaming" url:url];
    }
    //初始化AVURLAsset
    self.urlAsset = [AVURLAsset URLAssetWithURL:self.sourceURL options:nil];
    //设置AVAssetResourceLoaderDelegate代理
    [self.urlAsset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    //初始化AVPlayerItem
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    //观察playerItem.status属性
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    //切换当前AVPlayer播放器的视频源
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    self.playerLayer.player = self.player;
    //给AVPlayerLayer添加周期性调用的观察者，用于更新视频播放进度
    [self addProgressObserver];
}


//取消播放
-(void)destroyPlayer {
    //暂停视频播放
    [self.player pause];
    
    //隐藏playerLayer
//    [_playerLayer setHidden:YES];
    
    //取消下载任务
    if(_downloadOperation) {
        [_downloadOperation cancel];
        _downloadOperation = nil;
    }
    
    //取消查找本地视频缓存数据的NSOperation任务
//    [_queryCacheOperation cancel];
    
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_player removeTimeObserver:_timeObserver];
    
    _player = nil;
    _playerItem = nil;
    _playerLayer.player = nil;
    
    __weak __typeof(self) wself = self;
//    dispatch_async(self.cancelLoadingQueue, ^{
        //取消AVURLAsset加载，这一步很重要，及时取消到AVAssetResourceLoaderDelegate视频源的加载，避免AVPlayer视频源切换时发生的错位现象
        [wself.urlAsset cancelLoading];
        wself.data = nil;
        //结束所有视频数据加载请求
        [wself.pendingRequests enumerateObjectsUsingBlock:^(id loadingRequest, NSUInteger idx, BOOL * stop) {
            if(![loadingRequest isFinished]) {
                [loadingRequest finishLoading];
            }
        }];
        [wself.pendingRequests removeAllObjects];
//    });
    
//    _retried = NO;
    
}

#pragma kvo

// 给AVPlayerLayer添加周期性调用的观察者，用于更新视频播放进度
-(void)addProgressObserver{
    __weak __typeof(self) weakSelf = self;
    //AVPlayer添加周期性回调观察者，一秒调用一次block，用于更新视频播放进度
    _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if(weakSelf.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            //获取当前播放时间
            float current = CMTimeGetSeconds(time);
            //获取视频播放总时间
            float total = CMTimeGetSeconds([weakSelf.playerItem duration]);
            //重新播放视频
            if (@available(iOS 11.0, *))
            {
                if(total == current) {
//                    [weakSelf replay];
                    [weakSelf.player seekToTime:kCMTimeZero];
                    [weakSelf.player play];
                }
            } else {
                if(total <= ceil(current)) {
//                    [weakSelf replay];
                    [weakSelf.player seekToTime:kCMTimeZero];
                    [weakSelf.player play];
                }
            }
            //更新视频播放进度方法回调
            if(weakSelf.delegate) {
                [weakSelf.delegate onProgressUpdate:current total:total];
            }
        }
    }];
}

// 响应KVO值变化的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //AVPlayerItem.status
    if([keyPath isEqualToString:@"status"]) {
        if(_playerItem.status == AVPlayerItemStatusFailed) {
            DDLogWarn(@"Video status failed");
//            if(!_retried) {
//                [self retry];
//            }
        }
        //视频源装备完毕，则显示playerLayer
        if(_playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.playerLayer setHidden:NO];
            
//            [self.player play];
        }
        //视频播放状体更新方法回调
        if(_delegate) {
            [_delegate onPlayItemStatusUpdate:_playerItem.status];
        }
    }else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Delegate
#pragma mark AVAssetResourceLoaderDelegate协议

//  该函数表示代理类是否可以处理该请求，这里需要返回True表示可以处理该请求，然后在这里保存所有发出的请求，然后发出我们自己构造的NSUrlRequest。
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    DDLogVerbose(@"loadingRequest:%@", loadingRequest);
    //创建用于下载视频源的NSURLSessionDataTask，当前方法会多次调用，所以需判断self.task == nil
    if (!self.downloadOperation) {
        //将当前的请求路径的scheme换成https，进行普通的网络请求
        NSURL *url = [self urlScheme:self.sourceScheme url:[loadingRequest.request URL].absoluteString];
        [self startDownloadTask:url isBackground:YES];
    }
    //将视频加载请求依此存储到pendingRequests中，因为当前方法会多次调用，所以需用数组缓存
    [_pendingRequests addObject:loadingRequest];
    
    return YES;
}

// 该函数表示AVAssetResourceLoader放弃了本次请求，需要把该请求从我们保存的原始请求列表里移除。
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    //AVAssetResourceLoadingRequest请求被取消，移除视频加载请求
    [_pendingRequests removeObject:loadingRequest];
}

#pragma mark - Private
//开始视频资源下载任务
- (void)startDownloadTask:(NSURL *)URL isBackground:(BOOL)isBackground {
    // 已请求1M数据
//    DDLogInfo(@"url:%@,data:%lu",URL.absoluteString,(unsigned long)self.data.length);
//    if (self.data.length > 1024*1024) {
//        DDLogInfo(@"data > 1M");
//
//        NSString *rangeHeaderStr = [NSString stringWithFormat:@"byes=%lu-%llu",(unsigned long)self.data.length,self.expectedContentLength-self.data.length];
//        NSDictionary *header = @{@"Range":rangeHeaderStr};
//
//        if(self.downloadOperation) {
//            // 取消正在下载的任务
//            [self.downloadOperation cancel];
//            self.downloadOperation = nil;
//        }
//        // 加载后续数据
//        DDLogInfo(@"URL:%@,header:%@",URL,header);
//        self.downloadOperation = [[Downloader sharedDownloader] downloadWithURL:URL header:header responseBlock:^(NSHTTPURLResponse *response) {
////            self.data = [NSMutableData data];
////            self.mimeType = response.MIMEType;
////            self.expectedContentLength = response.expectedContentLength;
////            [self processPendingRequests];
//        } progressBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSData *data) {
//            [self.data appendData:data];
//            //处理视频数据加载请求
//            [self processPendingRequests];
//        } completedBlock:^(NSData *data, NSError *error, BOOL finished) {
//            if(!error && finished) {
//                DDLogVerbose(@"download finish");
//                //            [loadingRequest.dataRequest respondWithData:data];
//                //下载完毕，将缓存数据保存到本地
//                //            NSString *file = [NSString stringWithFormat:@"/Users/Joe/Desktop/download/douyin_%.0f.mp4",[NSDate date].timeIntervalSince1970];
//                //            [self.data writeToFile:file atomically:YES];
//                //            [self.data writeToFile:@"/Users/Joe/Desktop/download/douyin.mp4" atomically:YES];
//                //            [[WebCacheHelpler sharedWebCache] storeDataToDiskCache:wself.data key:wself.cacheFileKey extension:@"mp4"];
//                //            [self storeDataToDiskCache:self.data key:url.absoluteString extension:@"mp4"];
//            }
//        } cancelBlock:^{
//
//        } isBackground:isBackground];
//
////        if (!isBackground) {
////            [self play];
////
////        }
//        return;
//    }else{
//        DDLogInfo(@"data < 1M");
//
//    }
    
    if(self.downloadOperation) {
        // 取消正在下载的任务
        [self.downloadOperation cancel];
        self.downloadOperation = nil;
    }
    
    NSData *data = [[StorageManager manager] retrieveDataForKey:URL.absoluteString extension:@"mp4"];
    if (data) {
        DDLogInfo(@"%@ url is download!",URL.absoluteString);
        return;
    }
    
    self.downloadOperation = [[Downloader sharedDownloader] downloadWithURL:URL responseBlock:^(NSHTTPURLResponse *response) {
        self.data = [NSMutableData data];
        self.mimeType = response.MIMEType;
        self.expectedContentLength = response.expectedContentLength;
        [self processPendingRequests];
    } progressBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSData *data) {
        [self.data appendData:data];
        //处理视频数据加载请求
        [self processPendingRequests];
    } completedBlock:^(NSData *data, NSError *error, BOOL finished) {
        if(!error && finished) {
            //下载完毕，将缓存数据保存到本地
            [[StorageManager manager] storeData:data key:URL.absoluteString extension:@"mp4"];
            DDLogInfo(@"download finish");
            DDLogInfo(@"%@",[Downloader sharedDownloader].downloadBackgroundQueue.operations);
        }
    } cancelBlock:^{
        
    } isBackground:isBackground];
}

#pragma mark - Getter  &  Setter

- (void)processPendingRequests {
    NSMutableArray *requestsCompleted = [NSMutableArray array];
    //获取所有已完成AVAssetResourceLoadingRequest
    [_pendingRequests enumerateObjectsUsingBlock:^(AVAssetResourceLoadingRequest *loadingRequest, NSUInteger idx, BOOL * stop) {
        //判断AVAssetResourceLoadingRequest是否完成
        BOOL didRespondCompletely = [self respondWithDataForRequest:loadingRequest];
        //结束AVAssetResourceLoadingRequest
        if (didRespondCompletely){
            [requestsCompleted addObject:loadingRequest];
            [loadingRequest finishLoading];
        }
    }];
    //移除所有已完成AVAssetResourceLoadingRequest
    [self.pendingRequests removeObjectsInArray:requestsCompleted];
}


- (BOOL)respondWithDataForRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    //设置AVAssetResourceLoadingRequest的类型、支持断点下载、内容大小
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(_mimeType), NULL);
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    loadingRequest.contentInformationRequest.contentType = CFBridgingRelease(contentType);
    loadingRequest.contentInformationRequest.contentLength = _expectedContentLength;
    
    //AVAssetResourceLoadingRequest请求偏移量
    long long startOffset = loadingRequest.dataRequest.requestedOffset;
    if (loadingRequest.dataRequest.currentOffset != 0) {
        startOffset = loadingRequest.dataRequest.currentOffset;
    }
    //判断当前缓存数据量是否大于请求偏移量
    if (_data.length < startOffset) {
        return NO;
    }
    //计算还未装载到缓存数据
    NSUInteger unreadBytes = _data.length - (NSUInteger)startOffset;
    //判断当前请求到的数据大小
    NSUInteger numberOfBytesToRespondWidth = MIN((NSUInteger)loadingRequest.dataRequest.requestedLength, unreadBytes);
    //将缓存数据的指定片段装载到视频加载请求中
    [loadingRequest.dataRequest respondWithData:[_data subdataWithRange:NSMakeRange((NSUInteger)startOffset, numberOfBytesToRespondWidth)]];
    //计算装载完毕后的数据偏移量
    long long endOffset = startOffset + loadingRequest.dataRequest.requestedLength;
    //判断请求是否完成
    BOOL didRespondFully = _data.length >= endOffset;
    
    return didRespondFully;
}

- (NSURL *)urlScheme:(NSString *)scheme url:(NSString *)url {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:url] resolvingAgainstBaseURL:NO];
    components.scheme = scheme;
    return [components URL];
}


@end
