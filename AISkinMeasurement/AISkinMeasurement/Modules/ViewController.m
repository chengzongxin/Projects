//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import "SkinOverviewSection.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = @[@"123",@"222"];
    
    [self.adater reloadDataWithCompletion:nil];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(NSArray *)object {
//    id element = object.firstObject;
    if ([object isKindOfClass:[NSString class]]) {
        return SkinOverviewSection.new;
    }else{
        return nil;
    }
}


@end
