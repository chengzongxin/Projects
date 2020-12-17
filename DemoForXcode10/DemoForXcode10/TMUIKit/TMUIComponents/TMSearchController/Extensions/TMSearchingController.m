//
//  TMSearchingController.m
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/5.
//  Copyright © 2020 t8t. All rights reserved.
//

#import "TMSearchingController.h"
#import "TMUICommonDefines.h"

@interface TMSearchingController ()

@end

@implementation TMSearchingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;
}

TMUI_DEBUG_Code_Dealloc;

- (void)fuzzySearchForText:(nullable NSString *)searchText {};
- (void)clickSearchWithText:(nullable NSString *)searchText {};

@end
