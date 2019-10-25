//
//  OrderViewModel.m
//  Order
//
//  Created by Joe on 2019/10/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "OrderViewModel.h"
#import <MJExtension.h>

@implementation OrderViewModel

#pragma mark - 获取业务线列表
+(void)orderBusinessSystemQuery:(void (^)(NSArray<OrderBusinessModelData *> * _Nonnull))success fail:(void (^)(NSString * _Nonnull))fail{
    NSURL *url = [NSURL URLWithString:@"http://112.90.89.15:8888/mtfy-app-gw/order-app/command/orderBusinessSystemQuery"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtdGZ5IiwiZXhwIjoxNTc0NTc3NDA2LCJhZG1pbiI6IiIsInVzZXIiOnsidXNlcklkIjoiMjI0NjYiLCJuZXdVc2VySWQiOjIyNDY2LCJuYW1lIjoid2VubGluZ2ZlbmfljJfmtbfpgZPlkbXlkbUiLCJpY29uVXJsIjoiaHR0cDovL2F2YXRhci5tYXRhZnkuY29tLy04ODg3MzY5ODAucG5nIiwiY291bnRyeUNvZGUiOiIrODYiLCJtb2JpbGUiOiIxMzA4ODg1NTk1MiIsImV4cGlyZSI6MTU3NDU3NzQwNjM2MywicGxhdGZvcm0iOiJpb3MiLCJlcXVpcG1lbnRJZCI6IjY4MjE5NTg2IiwiaXNCaW5kIjp0cnVlLCJpc0F1dGgiOmZhbHNlLCJ0aGlyZHBhcnR5IjpudWxsLCJ0cFVpZCI6bnVsbCwidHBOaWNrbmFtZSI6bnVsbCwidHBBdmF0YXIiOm51bGx9fQ.sCBHs3ajX80emiZ6pkhcvD6yAUStyAT4Arzh0VCyzroDEcjd79bpHH7aNKVr1pnAtEHb8chAoI3_zdUkLWdRNA" forHTTPHeaderField:@"token"];
    NSLog(@"header = %@",request.allHTTPHeaderFields);
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        
        
        [OrderBusinessModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":OrderBusinessModelData.class};
        }];
        OrderBusinessModel *model = [OrderBusinessModel mj_objectWithKeyValues:json];
        NSLog(@"%@",model.data.firstObject.name);
        if (model.success) {
            // 添加全部分类
            OrderBusinessModelData *mix = [OrderBusinessModelData new];
            mix.name = @"全部分类";
            mix.code = @"MIX";
            // insert
            NSMutableArray *array = [model.data mutableCopy];
            [array insertObject:mix atIndex:0];
            model.data = [array copy];
            // callback
            success(model.data);
        }else{
            fail(model.message);
        }
    }];
    [dataTask resume];
}


#pragma mark - 订单列表查询
+ (void)orderSearchPageQueryWithOrderType:(NSString *)orderType
                                  catalog:(NSString *)catalog
                                     page:(int)page
                                     size:(int)size
                                  success:(void(^)(id data))success
                                     fail:(void(^)(NSString *message))fail{
    NSURL *url = [NSURL URLWithString:@"http://112.90.89.15:8888/mtfy-app-gw/order-app/command/orderSearchPageQuery"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJtdGZ5IiwiZXhwIjoxNTc0NTc3NDA2LCJhZG1pbiI6IiIsInVzZXIiOnsidXNlcklkIjoiMjI0NjYiLCJuZXdVc2VySWQiOjIyNDY2LCJuYW1lIjoid2VubGluZ2ZlbmfljJfmtbfpgZPlkbXlkbUiLCJpY29uVXJsIjoiaHR0cDovL2F2YXRhci5tYXRhZnkuY29tLy04ODg3MzY5ODAucG5nIiwiY291bnRyeUNvZGUiOiIrODYiLCJtb2JpbGUiOiIxMzA4ODg1NTk1MiIsImV4cGlyZSI6MTU3NDU3NzQwNjM2MywicGxhdGZvcm0iOiJpb3MiLCJlcXVpcG1lbnRJZCI6IjY4MjE5NTg2IiwiaXNCaW5kIjp0cnVlLCJpc0F1dGgiOmZhbHNlLCJ0aGlyZHBhcnR5IjpudWxsLCJ0cFVpZCI6bnVsbCwidHBOaWNrbmFtZSI6bnVsbCwidHBBdmF0YXIiOm51bGx9fQ.sCBHs3ajX80emiZ6pkhcvD6yAUStyAT4Arzh0VCyzroDEcjd79bpHH7aNKVr1pnAtEHb8chAoI3_zdUkLWdRNA" forHTTPHeaderField:@"token"];
    
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"22466" forKey:@"userId"];
    [body setValue:orderType forKey:@"orderType"];
    [body setValue:catalog forKey:@"catalog"];
    [body setValue:@(page).stringValue forKey:@"page"];
    [body setValue:@(size).stringValue forKey:@"size"];
    
    request.HTTPBody = [body mj_JSONData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        NSLog(@"%@--%@--%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],response,error);
        
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@--%@",json.class,json);
        
        
        
        [OrderBusinessModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":OrderBusinessModelData.class};
        }];
        OrderBusinessModel *model = [OrderBusinessModel mj_objectWithKeyValues:json];
        NSLog(@"%@",model.data.firstObject.name);
        if (model.success) {
            // 添加全部分类
            OrderBusinessModelData *mix = [OrderBusinessModelData new];
            mix.name = @"全部分类";
            mix.code = @"MIX";
            // insert
            NSMutableArray *array = [model.data mutableCopy];
            [array insertObject:mix atIndex:0];
            model.data = [array copy];
            // callback
            success(model.data);
        }else{
            fail(model.message);
        }
    }];
    [dataTask resume];
}
@end
