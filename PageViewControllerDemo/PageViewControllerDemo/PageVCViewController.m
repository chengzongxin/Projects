//
//  PageVCViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageVCViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "NormalViewController.h"

@interface PageVCViewController ()

@end

@implementation PageVCViewController

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageVC-Header";
}

- (NSArray<UIViewController *> *)pageChildViewControllers{
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"1232",@"13"];
    for (int i = 0; i < titleArr.count; i ++) {
        int num = i % 3;
        UIViewController *vc;
        if (num == 0) {
            vc = CollectionViewController.new;
        }else if (num == 1) {
            vc = TableViewController.new;
        }else{
            vc = NormalViewController.new;
        }
        //        vc.title = @(i).stringValue;
        vc.title = titleArr[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [vcArr addObject:vc];
    }
    return vcArr;
}

- (PageConfig *)pageConfig{
    PageConfig *config = PageConfig.config;
    config.itemNormalFont = [UIFont systemFontOfSize:18];
    config.itemSelectedFont = [UIFont systemFontOfSize:20];
    config.itemNormalColor = UIColor.greenColor;
    config.itemSelectedColor = UIColor.purpleColor;
    config.itemGradientsAnimate = NO;
    //    config.notAttachmentStyle = YES;
    //    config.trackerHidden = YES;
    
    
//    config.itemNormalImage = [UIImage imageNamed:@"coin_ls_btn_01"];
//    config.itemSelectedImage = [UIImage imageNamed:@"coin_ls_btn_02"];
    return config;
}

@end
