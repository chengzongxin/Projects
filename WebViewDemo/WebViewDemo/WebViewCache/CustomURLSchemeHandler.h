//
//  CustomURLSchemeHandler.h
//  WebViewDemo
//
//  Created by Joe on 2019/9/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const customscheme;

@interface CustomURLSchemeHandler : NSObject<WKURLSchemeHandler>


- (void)clearCache;

@end

@interface NSString (md5)

- (NSString *) md5;

@end


@interface NSFileManager (Tool)

+ (double)fileSizeAtPath:(NSString *)path;

+ (BOOL)clearFileAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
