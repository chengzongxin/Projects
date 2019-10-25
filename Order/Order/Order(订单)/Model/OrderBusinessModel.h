//
//  OrderBusinessModel.h
//  Order
//
//  Created by Joe on 2019/10/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class OrderBusinessModelData;
@interface OrderBusinessModel : NSObject
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSArray <OrderBusinessModelData *>* data;
@property (nonatomic, assign) BOOL error;
@property (nonatomic, assign) BOOL failure;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, assign) BOOL success;
@end


@interface OrderBusinessModelData : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * name;

@end
NS_ASSUME_NONNULL_END
