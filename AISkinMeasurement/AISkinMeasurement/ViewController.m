//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/20.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import "WZBCountdownLabel.h"
#import "SkinAnalysisView.h"
#import "SkinMeasureAlert.h"
@interface ViewController ()
@property (strong, nonatomic) SkinAnalysisView *ana;
@property (strong, nonatomic) SkinMeasureAlert *alert;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColor.darkGrayColor;
    
    self.navigationController.navigationBar.shadowImage = UIImage.new;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
    
//    [WZBCountdownLabel playWithNumber:3 endTitle:nil success:^(WZBCountdownLabel *label) {
//        NSLog(@"%s",__FUNCTION__);
//    }];
    
    
//    if (_ana) {
//        [_ana stopAnimation];
//        [_ana removeFromSuperview];
//        _ana = nil;
//        return;
//    }
//
//    SkinAnalysisView *ana = [[SkinAnalysisView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:ana];
//    _ana = ana;
    
//    if (_alert) {
//        [_alert dismiss];
//        _alert = nil;
//        return;
//    }
    
//    AlertView *alert = [[AlertView alloc] initWithTitle:@"123" subtitle:@"123123" confirm:@"confirm" cancel:@"cancel"];
//    [alert show];
//    _alert = alert;
    
    SkinMeasureAlert *alert = [[SkinMeasureAlert alloc] init];
    [alert show];
    
    __weak __typeof__(self)weakSelf = self;
    alert.tapItem = ^(int index) {
        if (index == 2) {
            // 测肤记录
            [weakSelf.navigationController pushViewController:UIViewController.new animated:YES];
        }
    };
    _alert = alert;
    
}


@end
