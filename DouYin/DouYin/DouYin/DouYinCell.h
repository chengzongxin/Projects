//
//  DouYinCell.h
//  DouYin
//
//  Created by Joe on 2019/7/17.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerView.h"
#import "DynamicListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DouYinCell : UITableViewCell

@property (strong, nonatomic) AVPlayerView *playerView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *playerStatusBar;

@property (strong, nonatomic) DynamicListModelDataList *model;

@property (nonatomic,copy) void (^onPlayerReady)(void);
@property (nonatomic, assign) BOOL             isPlayerReady;

- (void)startDownloadForegroundTask;

- (void)startDownloadBackgroundTask;

- (void)autoPlay;

@end

NS_ASSUME_NONNULL_END
