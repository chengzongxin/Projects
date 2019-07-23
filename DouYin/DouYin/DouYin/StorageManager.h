//
//  StorageManager.h
//  DouYin
//
//  Created by Joe on 2019/7/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//缓存清除完毕后的回调block
typedef void(^StorageClearCompletedBlock)(NSString *cacheSize);

@interface StorageManager : NSObject
//单例
+ (StorageManager *)manager;
//存储缓存数据到本地磁盘
- (void)storeData:(NSData *)data key:(NSString *)key;

- (void)storeData:(NSData *)data key:(NSString *)key extension:(nullable NSString *)extension;
// 根据key查询文件并返回文件名
- (NSString *)queryDataForKey:(NSString *)key extension:(nullable NSString *)extension;
// 根据key获取文件
- (NSData *)retrieveDataForKey:(NSString *)key extension:(nullable NSString *)extension;
//清除本地磁盘缓存数据
- (void)clearCache:(StorageClearCompletedBlock) cacheClearCompletedBlock;

@end

NS_ASSUME_NONNULL_END
