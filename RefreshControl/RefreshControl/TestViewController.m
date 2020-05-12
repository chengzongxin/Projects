//
//  TestViewController.m
//  RefreshControl
//
//  Created by Joe on 2020/5/12.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "TestViewController.h"
#import "RedView.h"
#import "YellowView.h"
@interface TestViewController ()
@property (strong, nonatomic) RedView *redView;
@property (strong, nonatomic) YellowView *yellowView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RedView *redView = [[RedView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:redView];
    _redView = redView;
    
    YellowView *yellowView = [[YellowView alloc] initWithFrame:CGRectMake(100, 0, 50, 50)];
    yellowView.backgroundColor = UIColor.yellowColor;
    [redView addSubview:yellowView];
    _yellowView = yellowView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
//    _redView.frame = CGRectMake(100, 100, 200, 300);
    _yellowView.frame = CGRectMake(100, 0, 50, 80);
}


@end
