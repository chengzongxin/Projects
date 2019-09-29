//
//  CustomURLSchemeHandler.m
//  WebViewDemo
//
//  Created by Joe on 2019/9/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "CustomURLSchemeHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>
//#import <SDWebImage.h>
//#import <SDWebImage/SDImageCache.h>
//#import <SDImageCache.h>

#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CTFramesetter.h>
#import <CoreText/CTFont.h>
#import <CoreText/CTStringAttributes.h>
#import "WKWebView+Cache.h"


NSString *const customscheme = @"customscheme";

//#define kLocalDirectory @"/Users/Joe/Desktop/Cache"

@interface CustomURLSchemeHandler ()

@property (strong, nonatomic) id<WKURLSchemeTask> urlSchemeTask;

@property (copy, nonatomic) NSString *localDirectory;

@end

@implementation CustomURLSchemeHandler

// MARK: 本地目录
- (NSString *)localDirectory{
    if (!_localDirectory) {
        _localDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Cache"];
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:_localDirectory];
        if (!exist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:_localDirectory withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
        }
//        _localDirectory = @"/Users/Joe/Desktop/Cache";
        NSLog(@"%@",_localDirectory);
    }
    return _localDirectory;
}

- (void)clearCache{
    [[NSFileManager defaultManager] removeItemAtPath:self.localDirectory error:nil];
}

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask{
    //加载本地资源
    NSLog(@"%@",urlSchemeTask.request.URL.absoluteString);
    
    NSDictionary *headers = urlSchemeTask.request.allHTTPHeaderFields;
    NSString *accept = headers[@"Accept"];
    NSLog(@"accept = %@",accept);

    NSString *urlString = urlSchemeTask.request.URL.absoluteString;
    NSString *fileName = [[urlString md5] stringByAppendingFormat:@".%@",[urlString pathExtension]];
    if ([urlString containsString:@"index"]) {
        fileName = [[urlString md5] stringByAppendingString:@".html"];
    }
    NSString *filePath = [self.localDirectory stringByAppendingPathComponent:fileName];
    
    
    [self queryCacheSize];
    
    //当前的requestUrl的scheme都是customScheme
    //文件不存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"文件不存在,开始下载");
        NSString *replacedStr = @"";
        NSString *schemeUrl = urlSchemeTask.request.URL.absoluteString;
        if ([schemeUrl hasPrefix:customscheme]) {
            replacedStr = [schemeUrl stringByReplacingOccurrencesOfString:customscheme withString:webView.originScheme];
        }
        NSLog(@"%@",replacedStr);
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:replacedStr]];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSLog(@"%f",1.0 * data.length / response.expectedContentLength);
            [urlSchemeTask didReceiveResponse:response];
            [urlSchemeTask didReceiveData:data];
            if (error) {
                [urlSchemeTask didFailWithError:error];
            } else {
//                NSLog(@"下载完成");
                [urlSchemeTask didFinish];
                
                [data writeToFile:filePath atomically:YES];
            }
        }];
        [dataTask resume];
    } else {
        NSLog(@"文件存在,读取缓存");
        NSData *data = [NSData dataWithContentsOfFile:filePath];

        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL
                                                            MIMEType:[self getMimeTypeWithFilePath:filePath]
                                               expectedContentLength:data.length
                                                    textEncodingName:nil];
        [urlSchemeTask didReceiveResponse:response];
        [urlSchemeTask didReceiveData:data];
        [urlSchemeTask didFinish];
    }
}

- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask{

}

//
//- (void)webView:(WKWebView *)webView startURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask{
//
//    NSLog(@"%@",urlSchemeTask.request.URL.absoluteString);
//
//    NSDictionary *headers = urlSchemeTask.request.allHTTPHeaderFields;
//    NSString *accept = headers[@"Accept"];
//
//    //当前的requestUrl的scheme都是customScheme
//    NSString *requestUrl = urlSchemeTask.request.URL.absoluteString;
//    NSString *fileName = [[requestUrl componentsSeparatedByString:@"?"].firstObject componentsSeparatedByString:@"/"].lastObject;
//
//    //Intercept and load local resources.
//    if ((accept.length >= @"text".length && [accept rangeOfString:@"text/html"].location != NSNotFound)) {//html 拦截
//        [self loadLocalFile:fileName urlSchemeTask:urlSchemeTask];
//    } else if ([self isMatchingRegularExpressionPattern:@"\\.(js|css)" text:requestUrl]) {//js、css
//        [self loadLocalFile:fileName urlSchemeTask:urlSchemeTask];
//    } else if (accept.length >= @"image".length && [accept rangeOfString:@"image"].location != NSNotFound) {//image
//        NSString *replacedStr = [requestUrl stringByReplacingOccurrencesOfString:customscheme withString:@"https"];
//        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:replacedStr]];
//
//        [SDWebImageManager.sharedManager.imageCache queryImageForKey:key options:0 context:nil completion:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
//            if (image) {
//                NSData *imgData = UIImageJPEGRepresentation(image, 1);
//                NSString *mimeType = [self getMimeTypeWithFilePath:fileName] ?: @"image/jpeg";
//                [self resendRequestWithUrlSchemeTask:urlSchemeTask mimeType:mimeType requestData:imgData];
//            } else {
//                [self loadLocalFile:fileName urlSchemeTask:urlSchemeTask];
//            }
//        }];
//
////        [[SDWebImageManager sharedManager].imageCache queryCacheOperationForKey:key done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
////            if (image) {
////                NSData *imgData = UIImageJPEGRepresentation(image, 1);
////                NSString *mimeType = [self getMimeTypeWithFilePath:fileName] ?: @"image/jpeg";
////                [self resendRequestWithUrlSchemeTask:urlSchemeTask mimeType:mimeType requestData:imgData];
////            } else {
////                [self loadLocalFile:fileName urlSchemeTask:urlSchemeTask];
////            }
////        }];
//    } else {//return an empty json.
//        NSData *data = [NSJSONSerialization dataWithJSONObject:@{ } options:NSJSONWritingPrettyPrinted error:nil];
//        [self resendRequestWithUrlSchemeTask:urlSchemeTask mimeType:@"text/html" requestData:data];
//    }
//}
//
////Load local resources, eg: html、js、css...
//- (void)loadLocalFile:(NSString *)fileName urlSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
//    if (fileName.length == 0 || !urlSchemeTask) {
//        return;
//    }
//
//    NSString *replacedStr;
//    //If the resource do not exist, re-send request by replacing to http(s).
////    NSString *filePath = [kGrassH5ResourcesFiles stringByAppendingPathComponent:fileName];
//    NSString *filePath = @"/Users/Joe/Desktop/Cache/cacheHtml.html";
//    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        if ([replacedStr hasPrefix:customscheme]) {
//            replacedStr = [replacedStr stringByReplacingOccurrencesOfString:customscheme withString:@"https"];
//        }
//
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:replacedStr]];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//            [urlSchemeTask didReceiveResponse:response];
//            [urlSchemeTask didReceiveData:data];
//            if (error) {
//                [urlSchemeTask didFailWithError:error];
//            } else {
//                [urlSchemeTask didFinish];
//
//                NSString *accept = urlSchemeTask.request.allHTTPHeaderFields[@"Accept"];
//                if (!(accept.length >= @"image".length && [accept rangeOfString:@"image"].location != NSNotFound)) { //图片不下载
//                    [data writeToFile:filePath atomically:YES];
//                }
//            }
//        }];
//        [dataTask resume];
//        [session finishTasksAndInvalidate];
//    } else {
//        NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
//        [self resendRequestWithUrlSchemeTask:urlSchemeTask mimeType:[self getMimeTypeWithFilePath:filePath] requestData:data];
//    }
//}
//
//- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask{
//
//}
//
//- (void)resendRequestWithUrlSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask
//                              mimeType:(NSString *)mimeType
//                           requestData:(NSData *)requestData  API_AVAILABLE(ios(11.0)) {
//    if (!urlSchemeTask || !urlSchemeTask.request || !urlSchemeTask.request.URL) {
//        return;
//    }
//
//    NSString *mimeType_local = mimeType ? mimeType : @"text/html";
//    NSData *data = requestData ? requestData : [NSData data];
//    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL
//                                                        MIMEType:mimeType_local
//                                           expectedContentLength:data.length
//                                                textEncodingName:nil];
//    [urlSchemeTask didReceiveResponse:response];
//    [urlSchemeTask didReceiveData:data];
//    [urlSchemeTask didFinish];
//}
//
//- (BOOL)isMatchingRegularExpressionPattern:(NSString *)pattern text:(NSString *)text {
//    if ([text containsString:@".js"] || [text containsString:@".css"] ) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

- (void)queryCacheSize{
    
    static int _queryTimes = 0;//查询100次,查一次,避免IO操作过于频繁
    
    if(_queryTimes >= 100) {
        _queryTimes = 0;
        return;
    }else if (_queryTimes == 0){
        // query
        _queryTimes ++;
    } else {
        _queryTimes ++;
        return;
    }
    
    double fileSize = [NSFileManager fileSizeAtPath:self.localDirectory];
    NSLog(@"fileSize = %f",fileSize);
    
    if (fileSize > 1024*1024*1024) {
        [NSFileManager clearFileAtPath:self.localDirectory];
    }
}

//根据路径获取MIMEType
- (NSString *)getMimeTypeWithFilePath:(NSString *)filePath{
    CFStringRef pathExtension = (__bridge_retained CFStringRef)[filePath pathExtension];
    CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
    CFRelease(pathExtension);
    
    //The UTI can be converted to a mime type:
    NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
    if (type != NULL)
        CFRelease(type);
    
    return mimeType;
}

@end

@implementation NSString (md5)

- (NSString *) md5 {
    const char *str = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( str, (CC_LONG)strlen(str), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

@end


@implementation NSFileManager (Tool)

+ (double)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSEnumerator *enumerator = [contents objectEnumerator];
    NSString *fileName;
    double folderSize = 0.0f;
    
    while((fileName = [enumerator nextObject])) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
    }
//    return [NSString stringWithFormat:@"%.2f",folderSize/1024.0f/1024.0f];
    return folderSize;
}

+ (BOOL)clearFileAtPath:(NSString *)path{
    
    BOOL allSeccess = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            NSError *error;
            BOOL success = [fileManager removeItemAtPath:absolutePath error:&error];
            if (!success) {
                NSLog(@"%@",error);
                allSeccess = NO;  // 删除某个文件失败
            }
        }
    }
    return allSeccess;
}

@end
