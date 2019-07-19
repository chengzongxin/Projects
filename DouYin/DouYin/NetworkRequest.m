//
//  NetworkRequest.m
//  DouYin
//
//  Created by Joe on 2019/6/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "NetworkRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkRequest

+ (void)postWithUrl:(NSString *)url para:(NSDictionary *)para dataHandle:(void(^)(id data))dataHanldle{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;// 3.设置超时时间
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];// 5.设置返回格式 (默认JSON, 这里必须改为二进制)
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"1234567" forHTTPHeaderField:@"deviceId"];
    
    [manager POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {

        DDLogInfo(@"Success: 参数是 %@,接口url是 %@ 请求成功,结果是 %@",para,url,[responseObject mj_JSONString]);

        [DynamicRecommendListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : [DynamicListModelDataList class]};
        }];
        [DynamicListModelDataList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"mediaContentList" : [DynamicListModelDataListMediaContentList class],
                     @"labels" : [NSString class]};
        }];

        DynamicRecommendListModel *model = [DynamicRecommendListModel mj_objectWithKeyValues:responseObject];
        if (model.code == 200) {
            dataHanldle(model.data);
        }
        NSLog(@"%@",model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"NET_failure:参数是 %@,接口url是 %@, 网络错误 %@",para,url,error.userInfo);
    }];
}


@end
