//
//  RefreshBaseView.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshBaseView.h"

@implementation RefreshBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.status = RefreshStatusNormal;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件移除监听
    [self removeObservers];
    //记录父视图
    self.superScrollView = (UIScrollView *)newSuperview;
    
    [self addObservers];
}

- (void)addObservers{
    //添加KVO监听父视图的偏移量
    [self.superScrollView addObserver:self forKeyPath:RefreshKeyPathContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self.superScrollView addObserver:self forKeyPath:RefreshKeyPathContentSize options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentSize];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:RefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    
    if ([keyPath isEqualToString:RefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}

- (void)startRefresh{}
- (void)stopRefresh{}

@end
