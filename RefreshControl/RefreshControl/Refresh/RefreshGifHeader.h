//
//  RefreshGifHeader.h
//  RefreshControl
//
//  Created by Joe on 2020/5/14.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "RefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface RefreshGifHeader : RefreshHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(RefreshStatus)state;
- (void)setImages:(NSArray *)images forState:(RefreshStatus)state;
@end

NS_ASSUME_NONNULL_END
