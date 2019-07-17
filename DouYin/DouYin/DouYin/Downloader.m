//
//  Downloader.m
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "Downloader.h"


#define SemaphoreBegin \
static dispatch_semaphore_t semaphore; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
semaphore = dispatch_semaphore_create(1); \
}); \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

#define SemaphoreEnd \
dispatch_semaphore_signal(semaphore);

@interface Downloader () 

@end

@implementation Downloader

//单例
+ (Downloader *)sharedDownloader {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

//初始化
- (instancetype)init {
    self = [super init];
    if(self) {
        //初始化并行下载队列
        _downloadConcurrentQueue = [NSOperationQueue new];
        _downloadConcurrentQueue.name = @"com.concurrent.webdownloader";
        _downloadConcurrentQueue.maxConcurrentOperationCount = 6;
        
        //初始化串行下载队列
        _downloadSerialQueue = [NSOperationQueue new];
        _downloadSerialQueue.name = @"com.serial.webdownloader";
        _downloadSerialQueue.maxConcurrentOperationCount = 1;
        
        
        //初始化后台串行下载队列
        _downloadBackgroundQueue = [NSOperationQueue new];
        _downloadBackgroundQueue.name = @"com.background.webdownloader";
        _downloadBackgroundQueue.maxConcurrentOperationCount = 1;
        _downloadBackgroundQueue.qualityOfService = NSQualityOfServiceBackground;
        
        //初始化高优先级下载队列
        _downloadPriorityHighQueue = [NSOperationQueue new];
        _downloadPriorityHighQueue.name = @"com.priorityhigh.webdownloader";
        _downloadPriorityHighQueue.maxConcurrentOperationCount = 1;
        _downloadPriorityHighQueue.qualityOfService = NSQualityOfServiceUserInteractive;
        [_downloadPriorityHighQueue addObserver:self forKeyPath:@"operations" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (WebDownloadOperation *)downloadWithURL:(NSURL *)url
                            responseBlock:(WebDownloaderResponseBlock)responseBlock
                            progressBlock:(WebDownloaderProgressBlock)progressBlock
                           completedBlock:(WebDownloaderCompletedBlock)completedBlock
                              cancelBlock:(WebDownloaderCancelBlock)cancelBlock
                             isBackground:(BOOL)isBackground{
    
    //未查找到则创建下载网络资源的WebDownloadOperation任务，并赋值组合任务WebCombineOperation
    //初始化网络资源下载请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    request.HTTPShouldUsePipelining = YES;
    WebDownloadOperation *downloadOperation = [[WebDownloadOperation alloc] initWithRequest:request responseBlock:^(NSHTTPURLResponse *response) {
        if(responseBlock) {
            responseBlock(response);
        }
    } progressBlock:progressBlock completedBlock:^(NSData *data, NSError *error, BOOL finished) {
        //网络资源下载完毕，处理返回数据
        if(completedBlock) {
            if(finished && !error) {
                //任务完成回调
                completedBlock(data, nil, YES);
            }else {
                //任务失败回调
                completedBlock(data, error, NO);
            }
        }
    } cancelBlock:^{
        //任务取消回调
        if(cancelBlock) {
            cancelBlock();
        }
    }];
    
    //将下载任务添加进队列
    if (isBackground) {
        //添加后台下载任务
        [self.downloadBackgroundQueue addOperation:downloadOperation];
    } else {
        //添加高优先级下载任务，队列中每次只执行1个任务
        [self.downloadPriorityHighQueue cancelAllOperations];
        [self.downloadPriorityHighQueue addOperation:downloadOperation];
    }
    return downloadOperation;
}

//更新当前正在执行的队列,保证downloadPriorityHighQueue执行任务时downloadBackgroundQueue暂停
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"operations"]) {
        @synchronized (self) {
            if ([_downloadPriorityHighQueue.operations count] == 0) {
                [_downloadBackgroundQueue setSuspended:NO];
            } else {
                [_downloadBackgroundQueue setSuspended:YES];
            }
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [_downloadPriorityHighQueue removeObserver:self forKeyPath:@"operations"];
}

@end

//自定义用于下载网络资源的NSOperation任务
@interface WebDownloadOperation ()

@property (nonatomic, copy) WebDownloaderResponseBlock responseBlock;     //下载进度响应block
@property (nonatomic, copy) WebDownloaderProgressBlock progressBlock;     //下载进度回调block
@property (nonatomic, copy) WebDownloaderCompletedBlock completedBlock;   //下载完成回调block
@property (nonatomic, copy) WebDownloaderCancelBlock cancelBlock;         //取消下载回调block
@property (nonatomic, strong) NSMutableData *data;                        //用于存储网络资源数据
@property (assign, nonatomic) NSInteger expectedSize;                     //网络资源数据总大小

@property (assign, nonatomic) BOOL executing;//判断NSOperation是否执行
@property (assign, nonatomic) BOOL finished;//判断NSOperation是否结束

@end

@implementation WebDownloadOperation

@synthesize executing = _executing;      //指定executing别名为_executing
@synthesize finished = _finished;        //指定finished别名为_finished

//初始化数据
- (instancetype)initWithRequest:(NSURLRequest *)request responseBlock:(WebDownloaderResponseBlock)responseBlock progressBlock:(WebDownloaderProgressBlock)progressBlock completedBlock:(WebDownloaderCompletedBlock)completedBlock cancelBlock:(WebDownloaderCancelBlock)cancelBlock {
    if ((self = [super init])) {
        _request = [request copy];
        _responseBlock = [responseBlock copy];
        _progressBlock = [progressBlock copy];
        _completedBlock = [completedBlock copy];
        _cancelBlock = [cancelBlock copy];
    }
    return self;
}

- (void)start {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    //判断任务执行前是否取消了任务
    if (self.isCancelled) {
        [self done];
        return;
    }
    @synchronized (self) {
        //创建网络资源下载请求，并设置网络请求代理
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = 15;
        _session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                 delegate:self
                                            delegateQueue:NSOperationQueue.mainQueue];
        _dataTask = [_session dataTaskWithRequest:_request];
        [_dataTask resume];
    }
}


-(BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isAsynchronous {
    return YES;
}

//取消任务
-(void)cancel {
    @synchronized (self) {
        [self done];
    }
}
//更新任务状态
- (void)done {
    [super cancel];
    if(_executing) {
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        _finished = YES;
        _executing = NO;
        [self didChangeValueForKey:@"isFinished"];
        [self didChangeValueForKey:@"isExecuting"];
        [self reset];
    }
    
}

//重置请求数据
- (void)reset {
    if(self.dataTask) {
        [_dataTask cancel];
    }
    if (self.session) {
        [self.session invalidateAndCancel];
        self.session = nil;
    }
}

//网络资源下载请求获得响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    if(_responseBlock) {
        _responseBlock(httpResponse);
    }
    NSInteger code = [httpResponse statusCode];
    if(code == 200) {
        completionHandler(NSURLSessionResponseAllow);
        self.data = [NSMutableData new];
        NSInteger expected = response.expectedContentLength > 0 ? (NSInteger)response.expectedContentLength : 0;
        self.expectedSize = expected;
    }else {
        completionHandler(NSURLSessionResponseCancel);
    }
}
//网络资源下载请求完毕
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(_completedBlock) {
        if(error) {
            if (error.code == NSURLErrorCancelled) {
                _cancelBlock();
            }else {
                _completedBlock(nil, error, NO);
            }
        }else {
            _completedBlock(self.data, nil, YES);
        }
    }
    [self done];
}
//接收网络资源下载数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.data appendData:data];
    
    if (self.progressBlock) {
        self.progressBlock(self.data.length, self.expectedSize, data);
    }
    
}
//网络缓存数据复用
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    NSCachedURLResponse *cachedResponse = proposedResponse;
    if (self.request.cachePolicy == NSURLRequestReloadIgnoringLocalCacheData) {
        cachedResponse = nil;
    }
    if (completionHandler) {
        completionHandler(cachedResponse);
    }
}

@end

