//
//  SkinMeasureRecordViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMeasureRecordViewController.h"
#import "SkinMeasureSelfViewController.h"
#import "SkinMeasureFriendViewController.h"

@interface SkinMeasureRecordViewController ()

@end

@implementation SkinMeasureRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测肤记录";
    self.view.backgroundColor = UIColor.whiteColor;
}

- (NSArray<UIViewController *> *)pageChildViewControllers{
    NSMutableArray *vcArr = [NSMutableArray array];
        NSArray *titleArr = @[@"自己",@"朋友"];
        for (int i = 0; i < 2; i ++) {
            int num = i % 3;
            UIViewController *vc;
            if (num == 0) {
                vc = SkinMeasureSelfViewController.new;
            }else if (num == 1) {
                vc = SkinMeasureFriendViewController.new;
            }else{
    //            vc = NormalViewController.new;
            }
            vc.title = titleArr[i];
            vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
            [vcArr addObject:vc];
        }
        return vcArr;
}

@end
