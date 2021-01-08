//
//  LiveTool.h
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import <Foundation/Foundation.h>
#import "LiveConst.h"
#import "TXLiteAVSDK_Professional/TXLiteAVSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveTool : NSObject

+ (NSString *)pushRtmpUrl;
+ (NSString *)LiveRtmpUrl;
+ (NSString *)getUserId;
+ (NSString *)getGroupId;

@end

NS_ASSUME_NONNULL_END
