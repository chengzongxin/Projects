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

@property (strong, nonatomic) DynamicListModelDataList *model;

- (void)startDownloadForegroundTask;
- (void)startDownloadBackgroundTask;

@end

NS_ASSUME_NONNULL_END
