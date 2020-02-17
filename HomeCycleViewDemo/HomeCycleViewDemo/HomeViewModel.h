//
//  HomeViewModel.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
+(void)request:(void (^)(id * _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;
@end

NS_ASSUME_NONNULL_END
