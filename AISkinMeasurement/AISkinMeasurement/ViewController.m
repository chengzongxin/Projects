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
@interface ViewController ()
@property (strong, nonatomic) UILabel *countingLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColor.darkGrayColor;
    
    self.navigationController.navigationBar.shadowImage = UIImage.new;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    [self.view addSubview:self.countingLabel];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
    
//    [WZBCountdownLabel playWithNumber:3 endTitle:nil success:^(WZBCountdownLabel *label) {
//        NSLog(@"%s",__FUNCTION__);
//    }];
    
    SkinAnalysisView *ana = [[SkinAnalysisView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:ana];
}


@end
