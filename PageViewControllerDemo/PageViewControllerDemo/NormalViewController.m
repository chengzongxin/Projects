//
//  NormalViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/10.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "NormalViewController.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.grayColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 允许滑动,当滑动到顶部时,激活
    PageScrollView *bgScrollView = (PageScrollView *)self.view.superview.superview;
    if ([bgScrollView isKindOfClass:PageScrollView.class]) {
//        CGFloat top = bgScrollView.headerView.height - bgScrollView.contentInset.top;
//        if (bgScrollView.contentOffset.y >= top) {
//            bgScrollView.fixed = NO;
//            bgScrollView.contentOffset = CGPointMake(0, top-0.1);
//        }
        bgScrollView.neverFixed = YES;
    }
    
}


@end
