//
//  OrderViewModel.h
//  Order
//
//  Created by Joe on 2019/10/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderBusinessModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderViewModel : NSObject

#pragma mark - 获取业务线列表
+ (void)orderBusinessSystemQuery:(void(^)(NSArray <OrderBusinessModelData *>* datas))success
                            fail:(void(^)(NSString *message))fail;

#pragma mark - 订单列表查询
+ (void)orderSearchPageQueryWithOrderType:(NSString *)orderType
                                  catalog:(NSString *)catalog
                                     page:(int)page
                                     size:(int)size
                                  success:(void(^)(id data))success
                                     fail:(void(^)(NSString *message))fail;

@end

NS_ASSUME_NONNULL_END
