//
//  WalletViewModel.h
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"


/* 资产管理 - 用户资产详情 */
#define URL_USER_ASSET_DETAIL_QUERY @"http://112.90.89.15:18807/token-wallet-app/asset/query/userAssetDetailQuery"

/* 资产管理 - 资金记录(订单)分页查询 */
#define URL_USER_ASSET_FLOW_PAGE_QUERY @"http://112.90.89.15:18807/token-wallet-app/asset/query/userAssetFlowPageQuery"

/* 基础数据 - 币种列表查询 */
#define URL_SYMBOL_LIST_QUERY @"http://112.90.89.15:18807/token-wallet-app/baseData/query/symbolListQuery"

/* 基础数据 - 订单类型列表查询 */
#define URL_ORDER_TYPE_LIST_QUERY @"http://112.90.89.15:18807/token-wallet-app/baseData/query/orderTypeListQuery"

/* 充值订单 - 充值地址查询 */
#define URL_RECHARGE_ADDR_QUERY @"http://112.90.89.15:18807/token-wallet-app/recharge/query/rechargeAddrQuery"

/* 充值订单 - 充值订单分页查询 */
#define URL_RECHARGE_ORDER_PAGE_QUERY @"http://112.90.89.15:18807/token-wallet-app/recharge/query/rechargeOrderPageQuery"

/* 充值订单 - 充值订单详情查询 */
#define URL_RECHARGE_ORDER_DETAIL_QUERY @"http://112.90.89.15:18807/token-wallet-app/recharge/query/rechargeOrderDetailQuery"


NS_ASSUME_NONNULL_BEGIN

@interface WalletViewModel : UIView


// 资产管理 - 用户资产详情
+ (void)userAssetDetailQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 资产管理 - 资金记录(订单)分页查询
+ (void)userAssetFlowPageQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 基础数据 - 币种列表查询
+ (void)symbolListQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 基础数据 - 订单类型列表查询
+ (void)orderTypeListQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 充值订单 - 充值地址查询
+ (void)rechargeAddrQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 充值订单 - 充值订单分页查询
+ (void)rechargeOrderPageQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;

// 充值订单 - 充值订单详情查询
+ (void)rechargeOrderDetailQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail;
@end

NS_ASSUME_NONNULL_END
