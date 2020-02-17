//
//  HomeViewModel.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

+(void)request:(void (^)(id * _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:@"https://rest.9e9.com/api/index/optimal_diff_price_info_list"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"afb4f799715746fa83cf9fd4dcc5d2f8" forHTTPHeaderField:@"token"];
    [request setValue:@"3.6.5" forHTTPHeaderField:@"version"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        
        
//        [OrderBusinessModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":OrderBusinessModelData.class};
//        }];
//        OrderBusinessModel *model = [OrderBusinessModel mj_objectWithKeyValues:json];
//        NSLog(@"%@",model.data.firstObject.name);
//        if (model.success) {
//            // 添加全部分类
//            OrderBusinessModelData *mix = [OrderBusinessModelData new];
//            mix.name = @"全部分类";
//            mix.code = @"MIX";
//            // insert
//            NSMutableArray *array = [model.data mutableCopy];
//            [array insertObject:mix atIndex:0];
//            model.data = [array copy];
//            // callback
//            success(model.data);
//        }else{
//            fail(model.message);
//        }
    }];
    [dataTask resume];
}
@end
