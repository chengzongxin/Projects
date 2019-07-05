//
//  Downloader.h
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

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

- (instancetype)initWithURL:(NSURL *)url completion:(void (^)(id _Nonnull))completion;

@end


//自定义用于下载网络资源的NSOperation任务
@interface WebDownloadOperation : NSOperation <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (strong, nonatomic, nullable) NSURLSession             *session;
@property (strong, nonatomic) NSURLSessionTask         *dataTask;
@property (strong, nonatomic, readonly) NSURLRequest   *request;
//初始化
- (instancetype)initWithRequest:(NSURLRequest *)request responseBlock:(WebDownloaderResponseBlock)responseBlock progressBlock:(WebDownloaderProgressBlock)progressBlock completedBlock:(WebDownloaderCompletedBlock)completedBlock cancelBlock:(WebDownloaderCancelBlock)cancelBlock;

@end



NS_ASSUME_NONNULL_END
