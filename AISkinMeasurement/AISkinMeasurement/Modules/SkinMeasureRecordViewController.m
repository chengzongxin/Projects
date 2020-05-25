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
#import "SPMultipleSwitch.h"

@interface SkinMeasureRecordViewController ()

@property (strong, nonatomic) SPMultipleSwitch *menu;

@end

@implementation SkinMeasureRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测肤记录";
    self.view.backgroundColor = UIColor.whiteColor;
    self.delegate = self;
    [self customMenu];
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

- (void)customMenu{
    UIView *menuBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, 44)];
    menuBG.backgroundColor = UIColor.whiteColor;
    
    _menu = [[SPMultipleSwitch alloc] initWithItems:@[@"自己",@"朋友"]];
    _menu.titleFont = [UIFont boldSystemFontOfSize:12];
    _menu.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width - 160)/2, 0, 160, 34);
    _menu.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    _menu.selectedTitleColor = UIColor.whiteColor;
    _menu.titleColor = [UIColor colorWithRed:121/255.0 green:132/255.0 blue:156/255.0 alpha:1.0];
    _menu.contentInset = 0;
    _menu.spacing = 10;
    _menu.trackerColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
    [_menu addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:menuBG];
    [menuBG addSubview:_menu];
}

- (void)switchAction:(SPMultipleSwitch *)sender{
    NSLog(@"%s",__FUNCTION__);
    [self scrollToIndex:sender.selectedSegmentIndex animate:YES];
}

- (void)pageViewController:(PageViewController *)pageViewController didScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",scrollView);
}

- (void)pageViewController:(PageViewController *)pageViewController didSelectWithIndex:(NSInteger)index{
    NSLog(@"%d",index);
    self.menu.selectedSegmentIndex = index;
}

@end
