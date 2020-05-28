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
#import "SkinCameraViewController.h"
#import "CombinationLabel.h"
@interface ViewController ()
@property (strong, nonatomic) SkinAnalysisView *ana;
@property (strong, nonatomic) AlertBaseView *alert;

@property (weak, nonatomic) IBOutlet CombinationLabel *combinationLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = UIColor.darkGrayColor;
    
    self.navigationController.navigationBar.shadowImage = UIImage.new;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    CombinationLabel *label = [[CombinationLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
//    label.backgroundColor = UIColor.whiteColor;
    [label setLeftText:@"肌肤良好指数啦啦啦" rightText:@"好"];
    [self.view addSubview:label];
    
    
    [self.combinationLabel setLeftText:@"肌肤良好指数" rightText:@"好"];
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
    
    AlertBaseView *alert = [[AlertBaseView alloc] initWithXib:[SkinMeasureAlert class]];
    __weak __typeof__(self)weakSelf = self;
    __weak __typeof__(AlertBaseView *)weakalert = alert;
    SkinMeasureAlert *custom = alert.customView;
    custom.tapItem = ^(int index) {
        
        switch (index) {
            case 0:// 自己
                [weakSelf.navigationController pushViewController:SkinCameraViewController.new animated:YES];
                break;
            case 1:// 朋友
                [weakSelf.navigationController pushViewController:SkinCameraViewController.new animated:YES];
                break;
            case 2:// 测肤记录
                [weakSelf.navigationController pushViewController:SkinMeasureRecordViewController.new animated:YES];
                break;
            default:
                break;
        }
        [weakalert dismiss];
    };
    [alert show];
    
}


@end
