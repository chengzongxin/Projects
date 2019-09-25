//
//  ViewController.m
//  WebViewDemo
//
//  Created by Joe on 2019/9/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "CustomURLSchemeHandler.h"

@interface ViewController ()

@property (copy, nonatomic) NSString *url;

@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    //https://m.matafy.com/hotel_test/index.html#/Choose
    self.url = @"://m.matafy.com/hotel_test/index.html#/Choose";
//    self.url = @"://m.matafy.com/medicalBeauty_test/index.html#/choose";
//    self.url = @"://www.taobao.com";
    [WKWebView new];
}

- (IBAction)buttonClick:(id)sender {
    NSString *url = [@"http" stringByAppendingString:self.url];
    WebViewController *web = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:web animated:YES];
    
}

- (IBAction)customClick:(id)sender {
    NSString *url = [customscheme stringByAppendingString:self.url];
    WebViewController *web = [[WebViewController alloc] initWithUrl:url];
    [self.navigationController pushViewController:web animated:YES];
    
}


- (IBAction)clear:(id)sender {
    
    //allWebsiteDataTypes清除所有缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}



@end
