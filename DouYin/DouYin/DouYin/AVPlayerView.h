//
//  AVPlayerView.h
//  DouYin
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

//自定义Delegate，用于进度、播放状态更新回调
@protocol AVPlayerViewDelegate

@required
//播放进度更新回调方法
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total;

//播放状态更新回调方法
-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status;

@end


@interface AVPlayerView : UIView
//播放进度、状态更新代理
@property(nonatomic, weak) id<AVPlayerViewDelegate> delegate;
//设置播放路径
- (void)setPlayerUrl:(NSString *)url;
//开始视频资源下载任务
- (void)startDownloadTask:(NSURL *)URL isBackground:(BOOL)isBackground;

//更新AVPlayer状态，当前播放则暂停，当前暂停则播放
- (void)updatePlayerState;

//播放
- (void)play;

//暂停
- (void)pause;

//重新播放
- (void)replay;

//设置播放进度到最开始
- (void)seekToBegin;

@end

NS_ASSUME_NONNULL_END
