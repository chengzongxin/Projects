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
