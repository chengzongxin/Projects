//
//  HomeCycleView.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeCycleView.h"
#import "HomeCycleSpreadCell.h"
#import "HomeCycleCurrencyCell.h"
#import "HomeCycleIndexCell.h"

#define kCellMargin 18
#define kCellWidth self.bounds.size.width - (kCellMargin*2)
#define kCellSpacing 8

@interface HomeCycleView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HomeCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 列表
        [self addSubview:self.collectionView];
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    self.collectionView.frame = self.bounds;
//}

#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        HomeCycleSpreadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleSpreadCell.class) forIndexPath:indexPath];
        return cell;
    }else if (indexPath.item == 1) {
        HomeCycleCurrencyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleCurrencyCell.class) forIndexPath:indexPath];
        return cell;
    }else {
        HomeCycleIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleIndexCell.class) forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.tapItem) {
//        self.tapItem(self.datas[indexPath.item]);
//    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat kMaxIndex = 3;
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 10.0;
    NSLog(@"%f,%f",velocity.x,scrollView.contentOffset.x);
    
    CGFloat targetIndex;
    
    if (velocity.x > 0) {
        // 左滑,cell右移动
        targetIndex = ceil(targetX / (kCellWidth + kCellSpacing));
    }else{
        // 右滑,cell左移动
        targetIndex = floor(targetX / (kCellWidth + kCellSpacing));
    }
    
    if (targetIndex < 0)
        targetIndex = 0;
    if (targetIndex > kMaxIndex)
        targetIndex = kMaxIndex;
    NSLog(@"%f",targetIndex * (kCellWidth + kCellSpacing) - kCellMargin);
    targetContentOffset->x = targetIndex * (kCellWidth + kCellSpacing) - kCellMargin;
}


#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //不滚动
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 242);
        //    layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 1000);
        //该方法也可以设置itemSize
        layout.itemSize = CGSizeMake(self.bounds.size.width - kCellMargin*2, self.bounds.size.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 8;
//        layout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
//        _collectionView.pagingEnabled = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(HomeCycleSpreadCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(HomeCycleSpreadCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(HomeCycleCurrencyCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(HomeCycleCurrencyCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(HomeCycleIndexCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(HomeCycleIndexCell.class)];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
