//
//  ViewController.m
//  WebViewDemo
//
//  Created by Joe on 2019/9/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WKWebView+Cache.h"

@interface ViewController ()

@property (copy, nonatomic) NSString *url;

@property (copy, nonatomic) NSArray *urls;

@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (assign, nonatomic) int currentIndex;

@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [WKWebView new];
    
    _currentIndex = 0;
    self.urlLabel.text = self.urls[_currentIndex];
    self.url = self.urls[_currentIndex];
    
    //手机序列号
//        NSString* identifierNumber = [[UIDevice currentDevice] uniqueIdentifier];
//        NSLog(@"手机序列号: %@",identifierNumber);
        //手机别名： 用户定义的名称
        NSString* userPhoneName = [[UIDevice currentDevice] name];
        NSLog(@"手机别名: %@", userPhoneName);
        //设备名称
        NSString* deviceName = [[UIDevice currentDevice] systemName];
        NSLog(@"设备名称: %@",deviceName );
        //手机系统版本
        NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
        NSLog(@"手机系统版本: %@", phoneVersion);
        //手机型号
        NSString* phoneModel = [[UIDevice currentDevice] model];
        NSLog(@"手机型号: %@",phoneModel );
        //地方型号  （国际化区域名称）
        NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
        NSLog(@"国际化区域名称: %@",localPhoneModel );
          
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // 当前应用名称
        NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSLog(@"当前应用名称：%@",appCurName);
        // 当前应用软件版本  比如：1.0.1
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"当前应用软件版本:%@",appCurVersion);
        // 当前应用版本号码   int类型
        NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
        NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    
}

- (IBAction)buttonClick:(id)sender {
    WebViewController *web = [[WebViewController alloc] initWithUrl:self.url];
    [self.navigationController pushViewController:web animated:YES];
    
}

- (IBAction)customClick:(id)sender {
    WebViewController *web = [[WebViewController alloc] initWithUrl:self.url];
    web.cacheEnable = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}


- (IBAction)clear:(id)sender {
    [WKWebView clearCache];
}

- (IBAction)nextClick:(id)sender {
    _currentIndex++;
    if (_currentIndex == self.urls.count) {
        _currentIndex = 0;
    }
    self.urlLabel.text = self.urls[_currentIndex];
    self.url = self.urls[_currentIndex];
}

- (NSArray *)urls{
    if (!_urls) {
        _urls = @[
                  @"http://mc.vip.qq.com/demo/indexv3",
                  @"https://m.matafy.com/tickets/index.html#/Choose",
                  @"https://m.matafy.com/hotel_test/index.html#/Choose",
                  @"https://m.matafy.com/train_test/index.html",
                  @"https://m.matafy.com/scenic_test/index.html#/Choose",
                  @"https://m.matafy.com/movie_test/index.html#/",
                  @"https://m.matafy.com/rentCarTest/index.html#/",
                  @"https://m.matafy.com/medicalBeauty_test/index.html#/choose"
                  ];
    }
    return _urls;
}

@end
