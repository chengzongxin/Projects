//
//  StorageManager.m
//  DouYin
//
//  Created by Joe on 2019/7/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "StorageManager.h"
#import "objc/runtime.h"
#import <CommonCrypto/CommonDigest.h>

@interface StorageManager ()

@property (nonatomic, strong) NSCache *memCache;               //内存缓存
@property (nonatomic, strong) NSFileManager *fileManager;      //文件管理类
@property (nonatomic, strong) NSURL *diskCacheDirectoryURL;    //本地磁盘文件夹路径
@property (nonatomic, strong) dispatch_queue_t ioQueue;        //查询缓存任务队列

@end


@implementation StorageManager

//单例
+ (StorageManager *)manager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
//初始化
-(instancetype)init {
    self = [super init];
    if(self) {
        //初始化内存缓存
        _memCache = [NSCache new];
        _memCache.name = @"webCache";
        _memCache.totalCostLimit = 50*1024*1024;
        
        //初始化文件管理类
        _fileManager = [NSFileManager defaultManager];
        
        //获取本地磁盘缓存文件夹路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path = [paths lastObject];
        NSString *diskCachePath = [NSString stringWithFormat:@"%@%@",path,@"/VideoDownload"];
        //判断是否创建本地磁盘缓存文件夹
        BOOL isDirectory = NO;
        BOOL isExisted = [_fileManager fileExistsAtPath:diskCachePath isDirectory:&isDirectory];
        if (!isDirectory || !isExisted){
            NSError *error;
            [_fileManager createDirectoryAtPath:diskCachePath withIntermediateDirectories:YES attributes:nil error:&error];
        }
        //本地磁盘缓存文件夹URL
        _diskCacheDirectoryURL = [NSURL fileURLWithPath:diskCachePath];
        //初始化查询缓存任务队列
        _ioQueue = dispatch_queue_create("com.start.webcache", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)storeData:(NSData *)data key:(NSString *)key{
    if(data && key) {
//        [self.memCache setObject:data forKey:key];
        [self storeData:data key:key extension:nil];
    }
}

//根据key值从本地磁盘中查询缓存数据，缓存数据返回路径包含文件类型
- (void)storeData:(NSData *)data key:(NSString *)key extension:(NSString *)extension {
    if(data && key) {
        NSString *fileName = [self diskCachePathForKey:key extension:extension];
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:data attributes:nil];
        
        [self storeDestktop:data];
    }
}

- (void)storeDestktop:(NSData *)data{
    NSString *file = [NSString stringWithFormat:@"/Users/Joe/Desktop/download/douyin_%.0f.mp4",[NSDate date].timeIntervalSince1970];
    [data writeToFile:file atomically:YES];
}

- (NSString *)queryDataForKey:(NSString *)key extension:(NSString *)extension{
    NSString *path = [self diskCachePathForKey:key extension:extension];
    return [[NSFileManager defaultManager] fileExistsAtPath:path] ? path : nil;
}

- (NSData *)retrieveDataForKey:(NSString *)key extension:(NSString *)extension{
    NSString *path = [self diskCachePathForKey:key extension:extension];
    return [NSData dataWithContentsOfFile:path];
}

//获取key值对应的磁盘缓存文件路径，文件路径包含指定扩展名
- (NSString *)diskCachePathForKey:(NSString *)key extension:(NSString *)extension {
    NSString *fileName = [self md5:key];
    NSString *cachePathForKey = [_diskCacheDirectoryURL URLByAppendingPathComponent:fileName].path;
    if(extension) {
        cachePathForKey = [cachePathForKey stringByAppendingFormat:@".%@", extension];
    }
    return cachePathForKey;
}

//清除内存和本地磁盘缓存数据
- (void)clearCache:(StorageClearCompletedBlock) cacheClearCompletedBlock {
    dispatch_async(_ioQueue, ^{
        [self clearMemoryCache];
        NSString *cacheSize = [self clearDiskCache];
        if(cacheClearCompletedBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cacheClearCompletedBlock(cacheSize);
            });
        }
    });
}

//清除内存缓存数据
- (void)clearMemoryCache {
    [_memCache removeAllObjects];
}

//清除本地磁盘缓存数据
- (NSString *)clearDiskCache {
    NSArray *contents = [_fileManager contentsOfDirectoryAtPath:_diskCacheDirectoryURL.path error:nil];
    NSEnumerator *enumerator = [contents objectEnumerator];
    NSString *fileName;
    CGFloat folderSize = 0.0f;
    
    while((fileName = [enumerator nextObject])) {
        NSString *filePath = [_diskCacheDirectoryURL.path stringByAppendingPathComponent:fileName];
        folderSize += [_fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
        [_fileManager removeItemAtPath:filePath error:NULL];
    }
    return [NSString stringWithFormat:@"%.2f",folderSize/1024.0f/1024.0f];
}

//key值进行md5签名
- (NSString *)md5:(NSString *)key {
    if(!key) {
        return @"temp";
    }
    const char *str = [key UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


@end
