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

@interface AVPlayerView : UIView
//设置播放路径
- (void)setPlayerUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
