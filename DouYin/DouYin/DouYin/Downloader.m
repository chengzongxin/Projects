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

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation Downloader

- (instancetype)initWithURL:(NSURL *)url completion:(void (^)(id _Nonnull))completion{
    if (self = [super init]) {
        
        //    let configuration = URLSessionConfiguration.default
        //    configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        //    configuration.networkServiceType = .video
        //    configuration.allowsCellularAccess = true
        //    var urlRequst = URLRequest.init(url: initialUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20) // 20s超时
        //    urlRequst.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        //    urlRequst.httpMethod = "GET"
        //    session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        //    session?.dataTask(with: urlRequst).resume()
        //}
        ////保存原始请求
        //self.pendingRequests.insert(loadingRequest)
        ////每次发送请求都遍历处理一遍原始请求数组
        //self.processPendingRequests()
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        configuration.networkServiceType = NSURLNetworkServiceTypeVideo;
        configuration.allowsCellularAccess = YES;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0];
        [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
        request.HTTPMethod = @"GET";
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                              delegate:self
                                                         delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
        [dataTask resume];
        
        
        self.session = session;
        self.dataTask = dataTask;
        
    }
    return self;
}



- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSLog(@"%s",__FUNCTION__);
}

// 1.接收到服务器响应的时候
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSLog(@"%s",__FUNCTION__);
}

// 2.接收到服务器返回数据的时候调用,会调用多次
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"%s",__FUNCTION__);
    
}

// 3.请求结束的时候调用(成功|失败),如果失败那么error有值
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
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
        self.progressBlock(self.data.length, self.expectedSize, self.data);
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

