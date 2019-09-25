//
//  WebViewController.m
//  WebViewDemo
//
//  Created by Joe on 2019/9/25.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "CustomURLSchemeHandler.h"

@interface WebViewController () <WKNavigationDelegate>

@property (copy, nonatomic) NSString *url;

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) NSDate *loadDate;

@end

@implementation WebViewController


- (instancetype)initWithUrl:(NSString *)aUrl{
    self = [super init];
    if (self) {
        self.url = aUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    //设置URLSchemeHandler来处理特定URLScheme的请求，URLSchemeHandler需要实现WKURLSchemeHandler协议
    //本例中WKWebView将把URLScheme为customScheme的请求交由CustomURLSchemeHandler类的实例处理
    [configuration setURLSchemeHandler:[CustomURLSchemeHandler new] forURLScheme:customscheme];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];//@"CustomScheme://www.baidu.com"
    [self.view addSubview:webView];
    self.webView = webView;
    
    self.loadDate = [NSDate date];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.loadDate];
    self.title = @(interval).stringValue;
}


@end
