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
+ (void)getMuseumCountries:(void(^)(MuseumCountriesModel *))success
                     fail:(void(^)(NSString *message))fail{


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];


    NSString *urlString = @"http://testone-mtfy-app-gw.matafy.com:8888/museum/getMuseumCountries";
//    NSString *urlString = @"https://mtfy-app-gw.matafy.com/museum/getMuseumCountries";
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        MuseumCountriesModel *model = [MuseumCountriesModel mj_objectWithKeyValues:responseObject];
        if (model.code == 200) {
            CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
            [self sort:model];
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
            NSLog(@"Linked in %f ms", linkTime *1000.0);
            success(model);
        }else{
            fail(model.message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        fail(@"网络异常");
    }];
}

+ (void)sort:(MuseumCountriesModel *)data{
    if (!data || data.data.all.count == 0) {
        return;
    }
    
    NSDictionary *pinyinDic = @{ @"A": @(1), @"B": @(2), @"C": @(3), @"D": @(4), @"E": @(5), @"F": @(6), @"G": @(7), @"H": @(8), @"I": @(9), @"J": @(10), @"K": @(11), @"L": @(12), @"M": @(13), @"N": @(14), @"O": @(15), @"P": @(16), @"Q": @(17), @"R": @(18), @"S": @(19), @"T": @(20), @"U": @(21), @"V": @(22), @"W": @(23), @"X": @(24), @"Y": @(25), @"Z": @(26) };
    
    for (MuseumCountriesModelDataAll *obj in data.data.all) {
        obj.sort_by = [[pinyinDic objectForKey:obj.firstletter.uppercaseString] intValue];
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sort_by" ascending:YES];
    data.data.all = [data.data.all sortedArrayUsingDescriptors:@[sort]];
    
    NSMutableArray *allArray = [NSMutableArray array];
    //将所有的key放进数组
    NSArray *allKeyArray = [pinyinDic allKeys];
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
//    NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
    
    for (int i = 0; i < 26; i ++) {
        MuseumCountriesModelDataSortAll *sortModel = MuseumCountriesModelDataSortAll.new;
        sortModel.firstletter = afterSortKeyArray[i];
        sortModel.all = [NSMutableArray array];
        [allArray addObject:sortModel];
    }
    
    for (int i = 0; i < 26; i ++) {
        MuseumCountriesModelDataSortAll *sortModel = allArray[i];
//        MuseumCountriesModelDataAll *obj = data.data.all[i];
        for (MuseumCountriesModelDataAll *obj in data.data.all) {
            if (([[pinyinDic objectForKey:obj.firstletter.uppercaseString] intValue] - 1) == i) {
                [sortModel.all addObject:obj];
            }
        }
    }
    
    // 去掉数组为0的元素
    NSMutableArray *filterArray = [NSMutableArray array];
    
    if (data.data.hot.count) {
        MuseumCountriesModelDataSortAll *hot = MuseumCountriesModelDataSortAll.new;
        hot.firstletter = @"热门国家";
        hot.all = [data.data.hot copy];
        [filterArray addObject:hot];
    }
    
    for (MuseumCountriesModelDataSortAll *obj in allArray) {
        if (obj.all.count) {
            [filterArray addObject:obj];
        }
    }
    
    data.data.sortAll = filterArray;
}


@end
