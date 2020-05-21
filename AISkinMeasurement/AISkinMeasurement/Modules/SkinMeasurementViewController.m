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
#import "SkinDoudouSection.h"
#import "SkinViewModel.h"

@interface SkinMeasurementViewController ()

@end

@implementation SkinMeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测肤报告";
    
    self.datas = @[@"88",@1,NSObject.new];
    
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
    if ([object isKindOfClass:[NSString class]]) {
        return SkinOverviewSection.new;
    }else if ([object isKindOfClass:[NSNumber class]]) {
        return SkinEightDimentionSection.new;
    }else if ([object isKindOfClass:[NSObject class]]) {
        return SkinDoudouSection.new;
    }else {
        return [super listAdapter:listAdapter sectionControllerForObject:object];
    }
}


@end




@interface NSObject (diff)
@end
@implementation NSObject (diff)
- (id<NSObject>)diffIdentifier {
    return self;
}
- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
    return [self isEqual:object];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

@end

