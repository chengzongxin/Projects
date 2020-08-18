//
//  CountryViewModel.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountryViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>

@implementation CountryViewModel
+ (void)getMuseumCountries:(void(^)(id MuseumCountriesModel))success
                     fail:(void(^)(NSString *message))fail{


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];


    NSString *urlString = @"http://testone-mtfy-app-gw.matafy.com:8888/museum/getMuseumCountries";
//    NSString *urlString = @"https://mtfy-app-gw.matafy.com/museum/getMuseumCountries";
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        MuseumCountriesModel *model = [MuseumCountriesModel mj_objectWithKeyValues:responseObject];
        if (model.code == 200) {
            success(model);
        }else{
            fail(model.message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        fail(@"网络异常");
    }];
}
@end
