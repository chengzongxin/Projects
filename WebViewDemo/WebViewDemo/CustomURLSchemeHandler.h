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

@end

NS_ASSUME_NONNULL_END
