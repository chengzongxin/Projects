//
//  WebCacheConst.m
//  WebViewDemo
//
//  Created by Joe on 2019/10/12.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "WebCacheConst.h"

NSString *const debugServer = @"https://m.matafy.com/offlineResources_test";
NSString *const releaseServer = @"https://m.matafy.com/offlineResources";

NSString *const ticketStr = @"tickets";//机票目录
NSString *const hotelStr = @"hotel";//酒店目录
NSString *const trainStr = @"train";//火车票目录
NSString *const scenicStr = @"scenic";//门票目录
NSString *const movieStr = @"movie";//电影票目录
NSString *const medicalBeautyStr = @"medicalBeauty";//医美目录
NSString *const rentCarStr = @"rentCar";//租车目录
NSString *const commonStr = @"common";//租车目录

@implementation WebCacheConst


#pragma mark - Lifecycle (dealloc init viewDidLoad memoryWarning...)

static WebCacheConst *_instance = nil;
+(instancetype) sharedInstance {
    
    static dispatch_once_t userOnceToken;
    dispatch_once(&userOnceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
#pragma mark - Public




#pragma mark - Event Respone

#pragma mark - Delegate

#pragma mark - Private

#pragma mark - Getters and Setters


- (NSString *)cacheDirectory{
    if (!_cacheDirectory) {
        _cacheDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Cache"];
        [self createDirectoryIfNeed:_cacheDirectory];
        NSLog(@"%@",_cacheDirectory);
    }
    return _cacheDirectory;
}

- (NSString *)ticketDirectory{
    if (!_ticketDirectory) {
        _ticketDirectory =[self.cacheDirectory stringByAppendingPathComponent:@"ticket"];
        [self createDirectoryIfNeed:_ticketDirectory];
    }
    return _ticketDirectory;
}

- (NSString *)hotelDirectory{
    if (!_hotelDirectory) {
        _hotelDirectory = [self.cacheDirectory stringByAppendingPathComponent:hotelStr];
        [self createDirectoryIfNeed:_hotelDirectory];
    }
    return _hotelDirectory;
}

- (NSString *)trainDirectory{
    if (!_trainDirectory) {
        _trainDirectory = [self.cacheDirectory stringByAppendingPathComponent:trainStr];
        [self createDirectoryIfNeed:_trainDirectory];
    }
    return _trainDirectory;
}

- (NSString *)scenicDirectory{
    if (!_scenicDirectory) {
        _scenicDirectory = [self.cacheDirectory stringByAppendingPathComponent:scenicStr];
        [self createDirectoryIfNeed:_scenicDirectory];
    }
    return _scenicDirectory;
}

- (NSString *)movieDirectory{
    if (!_movieDirectory) {
        _movieDirectory = [self.cacheDirectory stringByAppendingPathComponent:movieStr];
        [self createDirectoryIfNeed:_movieDirectory];
    }
    return _movieDirectory;
}

- (NSString *)medicalBeautyDirectory{
    if (!_medicalBeautyDirectory) {
        _medicalBeautyDirectory = [self.cacheDirectory stringByAppendingPathComponent:medicalBeautyStr];
        [self createDirectoryIfNeed:_medicalBeautyDirectory];
    }
    return _medicalBeautyDirectory;
}

- (NSString *)rentCarDirectory{
    if (!_rentCarDirectory) {
        _rentCarDirectory = [self.cacheDirectory stringByAppendingPathComponent:rentCarStr];
        [self createDirectoryIfNeed:rentCarStr];
    }
    return _rentCarDirectory;
}

- (NSString *)commonDirectory{
    if (!_commonDirectory) {
        _commonDirectory = [self.cacheDirectory stringByAppendingPathComponent:commonStr];
        [self createDirectoryIfNeed:_commonDirectory];
    }
    return _commonDirectory;
}

#pragma mark - Supperclass

#pragma mark - NSObject

// 创建文件夹
- (void)createDirectoryIfNeed:(NSString *)directoryPath{
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath];
    if (!exist) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%@",directoryPath);
    }
}

@end
