//
//  NetworkRequest.h
//  DouYin
//
//  Created by Joe on 2019/6/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "DynamicListModel.h"
#import "DynamicRecommendListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkRequest : NSObject

+ (void)postWithUrl:(NSString *)url para:(nullable NSDictionary *)para dataHandle:(void(^)(id data))dataHanldle;

@end

NS_ASSUME_NONNULL_END
