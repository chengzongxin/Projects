//
//  WalletViewModel.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "WalletViewModel.h"

@implementation WalletViewModel
// 资产管理 - 用户资产详情
+ (void)userAssetDetailQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_USER_ASSET_DETAIL_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
//        [DiffPriceModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":DiffPriceModelData.class};
//        }];
//
//        [DiffPriceModelData mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"symbolCurrentPriceVOS":DiffPriceModelDataSymbolCurrentPriceVOS.class};
//        }];
//
//        DiffPriceModel *model = [DiffPriceModel mj_objectWithKeyValues:json];
//
//        if (model.code == 200) {
//            success(model.data);
//        }else{
//            fail(model.msg);
//        }
    }];
    [dataTask resume];
}

// 资产管理 - 资金记录(订单)分页查询
+ (void)userAssetFlowPageQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_USER_ASSET_FLOW_PAGE_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
//        [HotSymbolModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":HotSymbolModelData.class};
//        }];
//
//        HotSymbolModel *model = [HotSymbolModel mj_objectWithKeyValues:json];
//
//        if (model.code == 200) {
//            success(model.data);
//        }else{
//            fail(model.msg);
//        }
    }];
    [dataTask resume];
}

// 基础数据 - 币种列表查询
+ (void)symbolListQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_SYMBOL_LIST_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        //        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":ExponentModelData.class};
        //        }];
        //
        //        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        //
        //        if (model.code == 200) {
        //            success(model.data);
        //        }else{
        //            fail(model.msg);
        //        }
    }];
    [dataTask resume];
}


// 基础数据 - 订单类型列表查询
+ (void)orderTypeListQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_ORDER_TYPE_LIST_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        //        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":ExponentModelData.class};
        //        }];
        //
        //        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        //
        //        if (model.code == 200) {
        //            success(model.data);
        //        }else{
        //            fail(model.msg);
        //        }
    }];
    [dataTask resume];
}

// 充值订单 - 充值地址查询
+ (void)rechargeAddrQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_RECHARGE_ADDR_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        //        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":ExponentModelData.class};
        //        }];
        //
        //        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        //
        //        if (model.code == 200) {
        //            success(model.data);
        //        }else{
        //            fail(model.msg);
        //        }
    }];
    [dataTask resume];
}

// 充值订单 - 充值订单分页查询
+ (void)rechargeOrderPageQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_RECHARGE_ORDER_PAGE_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        //        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":ExponentModelData.class};
        //        }];
        //
        //        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        //
        //        if (model.code == 200) {
        //            success(model.data);
        //        }else{
        //            fail(model.msg);
        //        }
    }];
    [dataTask resume];
}

// 充值订单 - 充值订单详情查询
+ (void)rechargeOrderDetailQuery:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:URL_RECHARGE_ORDER_DETAIL_QUERY];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        //        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":ExponentModelData.class};
        //        }];
        //
        //        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        //
        //        if (model.code == 200) {
        //            success(model.data);
        //        }else{
        //            fail(model.msg);
        //        }
    }];
    [dataTask resume];
}

@end
