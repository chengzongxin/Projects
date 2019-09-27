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

@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    //https://m.matafy.com/hotel_test/index.html#/Choose
//    self.url = @"://m.matafy.com/medicalBeauty_test/index.html#/choose";
//    self.url = @"://m.matafy.com/hotel_test/index.html#/Choose";
//    self.url = @"http://m.matafy.com/medicalBeauty_test/index.html#/choose";
//    self.url = @"://www.taobao.com";
    self.url = @"http://mc.vip.qq.com/demo/indexv3";
    [WKWebView new];
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



@end
