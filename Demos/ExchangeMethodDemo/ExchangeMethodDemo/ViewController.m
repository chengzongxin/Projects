//
//  ViewController.m
//  ExchangeMethodDemo
//
//  Created by Joe.cheng on 2021/3/5.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [ViewController runtimeLog];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear_原生的");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear_原生的");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewWillDisappear_原生的");
}

+ (void)runtimeLog{
    NSLog(@"RuntimeViewController");
}

@end
