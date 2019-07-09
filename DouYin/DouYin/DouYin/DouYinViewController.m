//
//  DouYinViewController.m
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "DouYinViewController.h"
#import "AVPlayerView.h"

@interface DouYinViewController ()

@end

@implementation DouYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = @"https://video1.matafy.com/pipixia/201906/pipixia_6705665578272561422.mp4";
    
    AVPlayerView *player = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:player];
    [player setPlayerUrl:url];
}


@end
