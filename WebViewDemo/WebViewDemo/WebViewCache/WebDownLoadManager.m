//
//  WebDownLoadManager.m
//  WebViewDemo
//
//  Created by Joe on 2019/10/12.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "WebDownLoadManager.h"
#import "WebCacheHelpler.h"
#import <ZipArchive.h>
#import "WebCacheConst.h"

@interface WebDownLoadManager ()

@property (copy, nonatomic) NSString *fileName;
//@property (copy, nonatomic) NSString *cacheDirectory;

@end

@implementation WebDownLoadManager

+ (void)downLoadH5Cache{
    [[[self alloc] init] downLoadH5Cache];
}

- (void)downLoadH5Cache{
    WebCacheConst *instance = WebCacheConst.sharedInstance;
//    NSString *server = instance.serverUrl;
//
//    NSString *ticketUrl = [server stringByAppendingPathComponent:instance.ticketUrl];
//    NSString *hotelUrl = [server stringByAppendingPathComponent:instance.hotelUrl];
//    NSString *trainUrl = [server stringByAppendingPathComponent:instance.trainUrl];
//    NSString *scenicUrl = [server stringByAppendingPathComponent:instance.scenicUrl];
//    NSString *movieUrl = [server stringByAppendingPathComponent:instance.movieUrl];
//    NSString *medicalBeautyUrl = [server stringByAppendingPathComponent:instance.medicalBeautyUrl];
//    NSString *rentCarUrl = [server stringByAppendingPathComponent:instance.rentCarUrl];
    
    NSArray *urls = @[instance.ticketUrl,instance.hotelUrl,instance.trainUrl,instance.scenicUrl,instance.movieUrl,instance.medicalBeautyUrl,instance.rentCarUrl];
    
    for (NSString *url in urls) {
        NSString *path = [url stringByAppendingPathExtension:@"zip"];
        [self downLoadWithUrl:path];
    }
}

- (void)downLoadWithUrl:(NSString *)urlString{
    NSURL *URL = [NSURL URLWithString:urlString];
    [[WebDownloader sharedDownloader] downloadWithURL:URL responseBlock:^(NSHTTPURLResponse *response) {
        //        wself.data = [NSMutableData data];
        //        wself.mimeType = response.MIMEType;
        //        wself.expectedContentLength = response.expectedContentLength;
        //        [wself processPendingRequests];
        self.fileName = response.suggestedFilename;
//        NSLog(@"%@--%lld",response.MIMEType,response.expectedContentLength);
    } progressBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSData *data) {
        //        [wself.data appendData:data];
        //        //处理视频数据加载请求
        //        [wself processPendingRequests];
//        NSLog(@"%zd--%zd",receivedSize,expectedSize);
    } completedBlock:^(NSData *data, NSError *error, BOOL finished) {
        if(!error && finished) {
            [self cacheFile:data];
            
            
            //下载完毕，将缓存数据保存到本地
            //            [[WebCacheHelpler sharedWebCache] storeDataToDiskCache:wself.data key:wself.cacheFileKey extension:@"mp4"];
        }
    } cancelBlock:^{
    } isBackground:YES];
}


- (void)cacheFile:(NSData *)data{
    // .zip文件解压后一个文件夹
    NSString *fullPath = [WebCacheConst.sharedInstance.cacheDirectory stringByAppendingPathComponent:self.fileName];
    [data writeToFile:fullPath atomically:YES];
    [SSZipArchive unzipFileAtPath:fullPath toDestination:WebCacheConst.sharedInstance.cacheDirectory];
    [NSFileManager.defaultManager removeItemAtPath:fullPath error:nil];
}


@end
