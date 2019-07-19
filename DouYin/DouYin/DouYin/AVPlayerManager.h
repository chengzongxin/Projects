//
//  AVPlayerManager.h
//  DouYin
//
//  Created by Joe on 2019/7/19.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerManager : NSObject

@property (copy, nonatomic) NSArray <NSString *>* urls;

- (void)playWithIndex:(int)index;

- (NSArray *)AVPlayerViews;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
