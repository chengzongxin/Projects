//
//  LiveTool.m
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import "LiveTool.h"
#import "NSString+md5.h"

@implementation LiveTool

+ (NSString *)pushRtmpUrl{
    return pushRtmpUrl;
}

+ (NSString *)LiveRtmpUrl{
    return [[self alloc] generateUrl];
}

+ (NSString *)getUserId{
    return [[[UIDevice currentDevice] name] MD5];
}

+ (NSString *)getGroupId{
    return @"19881122";
}

- (NSString *)generateUrl{
    NSURL *url = [NSURL URLWithString:pushRtmpUrl];
    NSDictionary *dict = [self paramerWithURL:url];
    NSString *txSecret = dict[@"txSecret"];
    NSString *txTime = dict[@"txTime"];
    NSString *md5txSecret = [NSString stringWithFormat:@"%@%@%@",txSecret,url.lastPathComponent,txTime];
    NSString *liveUrl = [NSString stringWithFormat:@"rtmp://%@%@?txSecret=%@&txTime=%@",url.host,url.path,[md5txSecret MD5],txTime];
    return liveUrl;
}

/**

获取url的所有参数

@param url 需要提取参数的url

@return NSDictionary

*/

-(NSDictionary *)paramerWithURL:(NSURL *) url {

    NSMutableDictionary *paramer = [[NSMutableDictionary alloc]init];

    //创建url组件类

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];

    //遍历所有参数，添加入字典

    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [paramer setObject:obj.value forKey:obj.name];

    }];

    return paramer;

}

@end
