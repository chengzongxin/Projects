//
//  PlayerViewController.m
//  DouYin
//
//  Created by Joe on 2019/7/18.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "PlayerViewController.h"
#import "AVPlayerView.h"

@interface PlayerViewController ()<AVPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) AVPlayerView *playerView;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    AVPlayerView *playerView = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
    playerView.delegate = self;
    [self.view addSubview:playerView];
    // 10
    [playerView setPlayerUrl:@"https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo/607272_373beb1043e8dae94026e937085934d0.mp4"];
    
    self.playerView = playerView;
}

- (void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status{
    if (status == AVPlayerItemStatusReadyToPlay) {
        [self.playerView play];
    }
}

- (void)onProgressUpdate:(CGFloat)current total:(CGFloat)total{
    self.currentLabel.text = @(current).stringValue;
    self.totalLabel.text = @(total).stringValue;
}

@end
