//
//  DouYinCell.m
//  DouYin
//
//  Created by Joe on 2019/7/17.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "DouYinCell.h"

@interface DouYinCell () <AVPlayerViewDelegate>

@end

@implementation DouYinCell

-(void)prepareForReuse {
    [super prepareForReuse];
    
    _isPlayerReady = NO;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    _playerView = [[AVPlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _playerView.delegate = self;
    [self addSubview:_playerView];
    
    //init player status bar
    CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenH = UIScreen.mainScreen.bounds.size.height;
    _playerStatusBar = [[UIView alloc] initWithFrame:CGRectMake(screenW - 0.5, screenH - 83 , 1, 0.5)];
    _playerStatusBar.backgroundColor = UIColor.whiteColor;
    [_playerStatusBar setHidden:YES];
    [self addSubview:_playerStatusBar];
    
}


//更新AVPlayer状态，当前播放则暂停，当前暂停则播放
- (void)tap:(UITapGestureRecognizer *)tap{
    [_playerView updatePlayerState];
}

- (void)setModel:(DynamicListModelDataList *)model{
    _model = model;
}

- (void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status{
    switch (status) {
        case AVPlayerItemStatusUnknown:
            [self startLoadingPlayItemAnim:YES];
            break;
        case AVPlayerItemStatusReadyToPlay:
            [self startLoadingPlayItemAnim:NO];
            
            _isPlayerReady = YES;
            
            if(_onPlayerReady) {
                _onPlayerReady();
            }
            break;
        case AVPlayerItemStatusFailed:
            [self startLoadingPlayItemAnim:NO];
            //            [UIWindow showTips:@"加载失败"];
            break;
        default:
            break;
    }
}


//加载动画
-(void)startLoadingPlayItemAnim:(BOOL)isStart {
    if (isStart) {
        _playerStatusBar.backgroundColor = UIColor.whiteColor;
        [_playerStatusBar setHidden:NO];
        [_playerStatusBar.layer removeAllAnimations];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
        animationGroup.duration = 0.5;
        animationGroup.beginTime = CACurrentMediaTime() + 0.5;
        animationGroup.repeatCount = MAXFLOAT;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animation];
        scaleAnimation.keyPath = @"transform.scale.x";
        scaleAnimation.fromValue = @(1.0f);
        scaleAnimation.toValue = @(1.0f * UIScreen.mainScreen.bounds.size.width);
        
        CABasicAnimation * alphaAnimation = [CABasicAnimation animation];
        alphaAnimation.keyPath = @"opacity";
        alphaAnimation.fromValue = @(1.0f);
        alphaAnimation.toValue = @(0.5f);
        [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
        [self.playerStatusBar.layer addAnimation:animationGroup forKey:nil];
    } else {
        [self.playerStatusBar.layer removeAllAnimations];
        [self.playerStatusBar setHidden:YES];
    }
    
}

- (void)onProgressUpdate:(CGFloat)current total:(CGFloat)total{
    
}

- (void)startDownloadForegroundTask{
    NSString *playUrl = _model.mediaContentList.lastObject.url;
    [_playerView startDownloadTask:[[NSURL alloc] initWithString:playUrl] isBackground:NO];
}

- (void)startDownloadBackgroundTask{
    [_playerView setPlayerUrl:_model.mediaContentList.lastObject.url];
}

@end
