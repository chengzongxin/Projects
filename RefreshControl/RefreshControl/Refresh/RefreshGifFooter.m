//
//  RefreshGifFooter.m
//  RefreshControl
//
//  Created by Joe on 2020/5/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "RefreshGifFooter.h"


@interface RefreshGifFooter ()
{
    __unsafe_unretained UIImageView *_gifView;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation RefreshGifFooter

- (void)prepare
{
//    [super prepare];

    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:RefreshStatusNormal];

    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:RefreshStatusPrepareRefresh];

    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:RefreshStatusRefreshing];
}


#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(RefreshStatus)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.height) {
        self.height = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(RefreshStatus)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - 实现父类的方法
//- (void)prepare
//{
//    [super prepare];
//
//    // 初始化间距
//    self.labelLeftInset = 20;
//}
//
//- (void)setPullingPercent:(CGFloat)pullingPercent
//{
//    [super setPullingPercent:pullingPercent];
//    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
//    if (self.state != MJRefreshStateIdle || images.count == 0) return;
//    // 停止动画
//    [self.gifView stopAnimating];
//    // 设置当前需要显示的图片
//    NSUInteger index =  images.count * pullingPercent;
//    if (index >= images.count) index = images.count - 1;
//    self.gifView.image = images[index];
//}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    self.gifView.contentMode = UIViewContentModeCenter;
}

- (void)setStatus:(RefreshStatus)status{
    [super setStatus:status];
    // 根据状态做事情
//    if (status & (RefreshStatusPrepareRefresh|RefreshStatusRefreshing)) {
        NSArray *images = self.stateImages[@(status)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(status)] doubleValue];
            [self.gifView startAnimating];
        }
//    } else if (status == RefreshStatusNormal) {
//        [self.gifView stopAnimating];
//    }
}



#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

@end
