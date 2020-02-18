//
//  HomeViewModel.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

+(void)request1:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:@"https://rest.9e9.com/api/index/optimal_diff_price_info_list"];
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
        
        [DiffPriceModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":DiffPriceModelData.class};
        }];
        
        [DiffPriceModelData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"symbolCurrentPriceVOS":DiffPriceModelDataSymbolCurrentPriceVOS.class};
        }];
        
        DiffPriceModel *model = [DiffPriceModel mj_objectWithKeyValues:json];
        
        if (model.code == 200) {
            success(model.data);
        }else{
            fail(model.msg);
        }
    }];
    [dataTask resume];
}

+(void)request2:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:@"https://rest.9e9.com/api/index/hot_symbol_info_list"];
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
        
        [HotSymbolModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":HotSymbolModelData.class};
        }];
        
        HotSymbolModel *model = [HotSymbolModel mj_objectWithKeyValues:json];
        
        if (model.code == 200) {
            success(model.data);
        }else{
            fail(model.msg);
        }
    }];
    [dataTask resume];
}

+(void)request3:(void (^)(id _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:@"https://rest.9e9.com/api/index/exponentList"];
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
        
        [ExponentModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":ExponentModelData.class};
        }];
        
        ExponentModel *model = [ExponentModel mj_objectWithKeyValues:json];
        
        if (model.code == 200) {
            success(model.data);
        }else{
            fail(model.msg);
        }
    }];
    [dataTask resume];
}
@end
