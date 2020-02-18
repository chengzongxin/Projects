//
//  HomeViewModel.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiffPriceModel.h"
#import "HotSymbolModel.h"
#import "ExponentModel.h"
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
+(void)request1:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;
+(void)request2:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;
+(void)request3:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;
@end

NS_ASSUME_NONNULL_END
