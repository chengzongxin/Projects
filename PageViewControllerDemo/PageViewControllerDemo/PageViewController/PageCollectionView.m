//
//  PageCollectionView.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageCollectionView.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"
#import "PageConst.h"
#import "UIScrollView+PageContent.h"

@implementation PageCollectionView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    NSLog(@"%s",__FUNCTION__);
    // 旧的父控件移除监听
    if (self.observationInfo) {
        [self removeObservers];
    }
    
    if (newSuperview) { // 新的父控件
        // 添加监听
        [self addObservers];
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;// | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:PageKeyPathContentOffset options:options context:nil];
    [self addObserver:self forKeyPath:PageKeyPathContentSize options:options context:nil];
}

- (void)removeObservers
{
    [self removeObserver:self forKeyPath:PageKeyPathContentOffset];
    [self removeObserver:self forKeyPath:PageKeyPathContentSize];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 这个就算看不见也需要处理
    if ([keyPath isEqualToString:PageKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:PageKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [self didScroll];
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self didScroll];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //    NSLog(@"%s",__FUNCTION__);
    //    if (otherGestureRecognizer.view.tag == 888) { // contentScrollView 不滑动
    //        return NO;
    //    }
    if ([otherGestureRecognizer.view isKindOfClass:PageScrollView.class]) {
        return YES;
    }
    
    //    NSLog(@"%@",otherGestureRecognizer.view);
    return NO;
}

@end
