//
//  LiveViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import "LiveViewController.h"
#import "LiveTool.h"

@interface LiveViewController ()<TXLivePlayListener>

@property (nonatomic, strong) TXLivePlayer *txLivePlayer;
@property (nonatomic, strong) UIView *playerView;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txLivePlayer = [[TXLivePlayer alloc] init];
    //用 setupVideoWidget 给播放器绑定决定渲染区域的view，其首个参数 frame 在 1.5.2 版本后已经被废弃
    _playerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _txLivePlayer.delegate = self;
    [self.view addSubview:_playerView];
    
    [_txLivePlayer setupVideoWidget:_playerView.bounds containView:_playerView insertIndex:0];
    
//    NSString* flvUrl = [LiveTool LiveRtmpUrl];
//    [_txLivePlayer startPlay:flvUrl type:PLAY_TYPE_LIVE_RTMP];
    NSString* testurl = @"rtmp://liveplay.to8to.com/live/95612_83b172176219_99babc3d37aa1998e782";
    [_txLivePlayer startPlay:testurl type:PLAY_TYPE_LIVE_RTMP];

}


- (void)onPlayEvent:(int)EvtID withParam:(NSDictionary *)param{
    NSLog(@"onPlayEvent %d-%@",EvtID,param);
}

- (void)onNetStatus:(NSDictionary *)param{
    NSLog(@"onNetStatus %@",param);
}


@end
