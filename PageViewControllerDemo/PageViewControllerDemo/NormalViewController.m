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
#import "UIViewController+Page.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.grayColor;
    
    self.notScrollView = YES;
}



@end
