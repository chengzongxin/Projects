//
//  CycleCellProtocol.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/18.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CycleCellProtocol <NSObject>

- (void)autoScroll;

- (void)willBeginDragging;

- (void)didEndDragging;

@end

#pragma mark - 基类方法
@interface CycleCell : UICollectionViewCell <CycleCellProtocol,UIScrollViewDelegate>
@property (nonatomic,weak) id<CycleCellProtocol> delegate;
@end

#pragma mark - 分类方法
@interface UICollectionView (index)

- (int)currentIndex;

- (void)scrollToNextItem;

@end

@implementation UICollectionView (index)

- (void)scrollToNextItem{
    int targetIndex = [self currentIndex] + 1;
//    [self scrollToIndex:targetIndex];
    
    
    CGFloat offset = self.frame.size.width * targetIndex;
    
    if (offset >= self.contentSize.width) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self setContentOffset:CGPointMake(offset, 0) animated:YES];
    }
}

- (int)currentIndex
{
    CGFloat kMaxIndex = [self numberOfItemsInSection:0];
    CGFloat offset = self.contentOffset.x;
    
//    int index = ceil(offset / (kCellWidth + kCellSpacing));
    int index = ceil(offset / self.bounds.size.width);
    
    if (index < 0)
        index = 0;
    if (index > kMaxIndex)
        index = kMaxIndex;
    return index;
}

- (void)scrollToIndex:(int)targetIndex
{
    NSInteger count = [self numberOfItemsInSection:0];
    if (targetIndex >= count) {
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else{
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

@end

NS_ASSUME_NONNULL_END
