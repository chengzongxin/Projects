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
@interface SkinMeasurementViewController ()

@end

@implementation SkinMeasurementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = @[@"123",@1,@"123123",@"534324",@54];
    
    [self.adater reloadDataWithCompletion:nil];
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
