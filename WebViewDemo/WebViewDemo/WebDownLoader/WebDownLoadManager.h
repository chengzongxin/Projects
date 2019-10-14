//
//  WebDownLoadManager.h
//  WebViewDemo
//
//  Created by Joe on 2019/10/12.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebDownLoadManager : NSObject

/* 下载H5离线文件 */
+ (void)downLoadH5Cache;

- (void)downLoadH5Cache;
/* 下载资源 */
- (void)downLoadWithUrl:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
