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

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) UIView *cacheView;
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
    [self.view insertSubview:playerView atIndex:0];
    
    // 10
    [playerView setPlayerUrl:@"https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo/607272_373beb1043e8dae94026e937085934d0.mp4"];
//    [playerView setPlayerUrl:@"ftp://ygdy8:ygdy8@yg45.dydytt.net:4207/阳光电影www.ygdy8.com.复仇者联盟4：终局之战.HD.720p.中英双字幕.mkv"];
    self.playerView = playerView;
    
    UIView *cache = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.slider.frame.size.width, 1)];
    cache.backgroundColor = UIColor.orangeColor;
    [self.slider addSubview:cache];
    self.cacheView = cache;
}

- (void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status{
    if (status == AVPlayerItemStatusReadyToPlay) {
        [self.playerView play];
    }
}

- (void)onProgressUpdate:(CGFloat)current total:(CGFloat)total{
    self.currentLabel.text = [self unitTrans:current];
    self.totalLabel.text = [self unitTrans:total];
    self.slider.maximumValue = total;
    
    CGRect frame = self.cacheView.frame;
    frame.size.width = current / total * self.slider.frame.size.width;
    self.cacheView.frame = frame;
}
- (IBAction)sliderChange:(UISlider *)slider {
    [self.playerView seekToProgress:slider.value];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.playerView updatePlayerState];
}

- (NSString *)unitTrans:(float)value{
    if (value < 60) {
        return [NSString stringWithFormat:@"00:%02f",ceilf(value)];
    }else {
        return [NSString stringWithFormat:@"%02f:%02f",ceilf(value) / 60,(float)((int)value % 60)];
    }
}

@end
