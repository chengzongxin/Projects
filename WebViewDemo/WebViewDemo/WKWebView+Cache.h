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


+ (void)customScheme;
/* 必须在loadrequest 之前启用缓存 */
- (void)cacheEnable;

@end

NS_ASSUME_NONNULL_END
