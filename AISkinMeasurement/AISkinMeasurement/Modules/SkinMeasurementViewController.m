//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMeasurementViewController.h"
#import "SkinViewModel.h"
#import "SkinOverviewSection.h"
#import "SkinEightDimentionSection.h"
#import "SkinDoudouSection.h"
#import "SkinBandianSection.h"
#import "SkinHeitouSection.h"
#import "SkinZhouwenSection.h"
#import "SkinMaokongSection.h"
#import "SkinHeiyanquanSection.h"

@interface SkinMeasurementViewController ()

@end

@implementation SkinMeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测肤报告";
    
    self.datas = @[@88,@"肌肤八维",@"痘痘",@"斑点",@"黑头",@"皱纹",@"毛孔",@"黑眼圈"];
    
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

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return SkinOverviewSection.new;
    }else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:self.datas[1]]) {
            return SkinEightDimentionSection.new;
        }else if ([object isEqualToString:self.datas[2]]) {
            return SkinDoudouSection.new;
        }else if ([object isEqualToString:self.datas[3]]) {
            return SkinBandianSection.new;
        }else if ([object isEqualToString:self.datas[4]]) {
            return SkinHeitouSection.new;
        }else if ([object isEqualToString:self.datas[5]]) {
            return SkinZhouwenSection.new;
        }else if ([object isEqualToString:self.datas[6]]) {
            return SkinMaokongSection.new;
        }else if ([object isEqualToString:self.datas[7]]) {
            return SkinHeiyanquanSection.new;
        }else{
            return [super listAdapter:listAdapter sectionControllerForObject:object];
        }
    }else {
        return [super listAdapter:listAdapter sectionControllerForObject:object];
    }
}


@end

