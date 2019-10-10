//
//  WKWebView+Cache.h
//  WebViewDemo
//
//  Created by Joe on 2019/9/27.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Cache)
/* 原始scheme */
@property (copy, nonatomic, readonly) NSString *originScheme;
/* 启用离线缓存 */
@property (assign, nonatomic) BOOL cacheEnable;
/* 最大沙盒缓存,默认 1024*1024*1024 bytes = 1GB,单位bytes */
@property (assign, nonatomic) float maxDiskCache;

+ (void)clearCache;

@end

NS_ASSUME_NONNULL_END
