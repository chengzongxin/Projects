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
#import "AlertBaseView.h"
#import "SkinMeasureRecordViewController.h"
@interface ViewController ()
@property (strong, nonatomic) SkinAnalysisView *ana;
@property (strong, nonatomic) AlertBaseView *alert;


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
    
    AlertBaseView *alert = [[AlertBaseView alloc] init];
    [alert show];
    SkinMeasureAlert *customView =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SkinMeasureAlert class]) owner:nil options:nil] firstObject];
    alert.customView = customView;
    __weak __typeof__(self)weakSelf = self;
    __weak __typeof__(AlertBaseView *)weakalert = alert;
    customView.tapItem = ^(int index) {
        if (index == 2) {
            // 测肤记录
            [weakSelf.navigationController pushViewController:SkinMeasureRecordViewController.new animated:YES];
            [weakalert dismiss];
        }
    };
    _alert = alert;
    
}


@end
