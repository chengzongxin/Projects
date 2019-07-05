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
    
    NSString *url = @"https://flight-feed.qunarzz.com/video_ft/prod/2018/7/d6cf49960816780cb1fd2771cf6ef764.mp4";
    
    AVPlayerView *player = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:player];
    [player setPlayerUrl:url];
}


@end
