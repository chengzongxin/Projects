//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMeasurementViewController.h"
#import "SkinOverviewSection.h"
#import "SkinEightDimentionSection.h"
#import "SkinViewModel.h"
@interface SkinMeasurementViewController ()

@end

@implementation SkinMeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测肤报告";
    
    self.datas = @[@"88",@1,@"90",@"99",@54];
    
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"skin_camera_switch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"skin_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];


    self.navigationItem.rightBarButtonItems = @[cameraItem,shareItem];
    
    [self.adater reloadDataWithCompletion:nil];
    
    [SkinViewModel analysisInfoQuery:@"123" recordNo:@"123" success:^(id  _Nonnull data) {
        NSLog(@"%@",data);
    } fail:^(NSString * _Nonnull message) {
        NSLog(@"%@",message);
    }];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(NSArray *)object {
//    id element = object.firstObject;
    if ([object isKindOfClass:[NSString class]]) {
        return SkinOverviewSection.new;
    }else if ([object isKindOfClass:[NSNumber class]]) {
        return SkinEightDimentionSection.new;
    }else {
        return nil;
    }
}


@end
