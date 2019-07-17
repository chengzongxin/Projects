//
//  Downloader.h
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebDownloadOperation;

//缓存清除完毕后的回调block
typedef void(^WebCacheClearCompletedBlock)(NSString *cacheSize);
//缓存查询完毕后的回调block，data返回类型包括NSString缓存文件路径、NSData格式缓存数据
typedef void(^WebCacheQueryCompletedBlock)(id data, BOOL hasCache);
//网络资源下载响应的回调block
typedef void(^WebDownloaderResponseBlock)(NSHTTPURLResponse *response);
//网络资源下载进度的回调block
typedef void(^WebDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSData *data);
//网络资源下载完毕后的回调block
typedef void(^WebDownloaderCompletedBlock)(NSData *data, NSError *error, BOOL finished);
//网络资源下载取消后的回调block
typedef void(^WebDownloaderCancelBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface Downloader : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

//用于处理下载任务的NSOperationQueue队列
@property (strong, nonatomic) NSOperationQueue *downloadConcurrentQueue;
@property (strong, nonatomic) NSOperationQueue *downloadSerialQueue;

@property (strong, nonatomic) NSOperationQueue *downloadBackgroundQueue;
@property (strong, nonatomic) NSOperationQueue *downloadPriorityHighQueue;
//单例
+ (Downloader *)sharedDownloader;
//下载指定URL网络资源

- (WebDownloadOperation *)downloadWithURL:(NSURL *)url
                           responseBlock:(WebDownloaderResponseBlock)responseBlock
                           progressBlock:(WebDownloaderProgressBlock)progressBlock
                          completedBlock:(WebDownloaderCompletedBlock)completedBlock
                             cancelBlock:(WebDownloaderCancelBlock)cancelBlock
                            isBackground:(BOOL)isBackground;

@end


//自定义用于下载网络资源的NSOperation任务
@interface WebDownloadOperation : NSOperation <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (strong, nonatomic, nullable) NSURLSession             *session;
@property (strong, nonatomic) NSURLSessionTask         *dataTask;
@property (strong, nonatomic, readonly) NSURLRequest   *request;
//初始化
- (instancetype)initWithRequest:(NSURLRequest *)request
                  responseBlock:(WebDownloaderResponseBlock)responseBlock
                  progressBlock:(WebDownloaderProgressBlock)progressBlock
                 completedBlock:(WebDownloaderCompletedBlock)completedBlock
                    cancelBlock:(WebDownloaderCancelBlock)cancelBlock;
@end



NS_ASSUME_NONNULL_END
