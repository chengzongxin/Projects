//
//  WebCacheConst.h
//  WebViewDemo
//
//  Created by Joe on 2019/10/12.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>


// MARK: 服务器地址
extern NSString *const debugServer;
extern NSString *const releaseServer;
// MARK: 路径path 拼接.zip
extern NSString *const ticketStr;
extern NSString *const hotelStr;
extern NSString *const trainStr;
extern NSString *const scenicStr;
extern NSString *const movieStr;
extern NSString *const medicalBeautyStr;
extern NSString *const rentCarStr;

extern NSString *const commonStr;
//#define CacheDirectory @"/Users/Joe/Desktop/Cache"


NS_ASSUME_NONNULL_BEGIN

@interface WebCacheConst : NSObject

+ (instancetype)sharedInstance;

@property (copy, nonatomic) NSString *cacheDirectory;

@property (copy, nonatomic) NSString *ticketDirectory;
@property (copy, nonatomic) NSString *hotelDirectory;
@property (copy, nonatomic) NSString *trainDirectory;
@property (copy, nonatomic) NSString *scenicDirectory;
@property (copy, nonatomic) NSString *movieDirectory;
@property (copy, nonatomic) NSString *medicalBeautyDirectory;
@property (copy, nonatomic) NSString *rentCarDirectory;

@property (copy, nonatomic) NSString *commonDirectory;
//+ (NSString *)cacheDirectory;

@end

NS_ASSUME_NONNULL_END
