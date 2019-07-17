//
//  DouYinCell.m
//  DouYin
//
//  Created by Joe on 2019/7/17.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "DouYinCell.h"

@implementation DouYinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    _playerView = [[AVPlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self addSubview:_playerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}


//更新AVPlayer状态，当前播放则暂停，当前暂停则播放
- (void)tap:(UITapGestureRecognizer *)tap{
    [_playerView updatePlayerState];
}

- (void)setModel:(DynamicListModelDataList *)model{
    _model = model;
}

- (void)startDownloadForegroundTask{
    NSString *playUrl = _model.mediaContentList.lastObject.url;
    [_playerView startDownloadTask:[[NSURL alloc] initWithString:playUrl] isBackground:NO];
}

- (void)startDownloadBackgroundTask{
    [_playerView setPlayerUrl:_model.mediaContentList.lastObject.url];
}

@end
