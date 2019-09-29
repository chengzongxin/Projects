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

@property (copy, nonatomic, readonly) NSString *originScheme;

@property (assign, nonatomic) BOOL cacheEnable;
/* 最大沙盒缓存,默认1024MB,单位MB */
@property (assign, nonatomic) float maxDiskCache;

+ (void)clearCache;

@end

NS_ASSUME_NONNULL_END
