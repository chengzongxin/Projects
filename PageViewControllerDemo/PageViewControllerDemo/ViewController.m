//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:1 usingBlock:^(id<AspectInfo> info){
        NSLog(@"hook viewwillapper");
        [super viewWillAppear:YES];
    } error:nil];
}

@end
