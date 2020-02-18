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
#import "HomeViewModel.h"
#import "HomePageControl.h"
#import "CycleCellProtocol.h"

#define kCellMargin 18
#define kCellWidth self.bounds.size.width - (kCellMargin*2)
#define kCellSpacing 8

@interface HomeCycleView () <UICollectionViewDelegate,UICollectionViewDataSource,CycleCellProtocol>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@property (nonatomic,strong) HomePageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation HomeCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 列表
        [self addSubview:self.collectionView];
        
        [self addSubview:self.pageControl];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:999 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        [self setupTimer];
    }
    return self;
}

#pragma mark - timer

- (void)setupTimer
{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll
{
//    if (0 == _totalItemsCount) return;
    int currentIndex = [self currentIndex];
    CycleCell *cell = (CycleCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]];
    [cell autoScroll];
}

- (int)currentIndex
{
    CGFloat kMaxIndex = [self.collectionView numberOfItemsInSection:0];;
    CGFloat offset = _collectionView.contentOffset.x;
    
    int index = ceil(offset / (kCellWidth + kCellSpacing));
    
    if (index < 0)
        index = 0;
    if (index > kMaxIndex)
        index = kMaxIndex;
    return index;
}

#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CycleCell *cell;
    
    switch (indexPath.item % 3) {
        case 0:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleSpreadCell.class) forIndexPath:indexPath];
            break;
        case 1:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleCurrencyCell.class) forIndexPath:indexPath];
            break;
        case 2:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HomeCycleIndexCell.class) forIndexPath:indexPath];
            break;
    }
    
//    [self layer:cell.layer applyShadow:UIColor.blackColor alpha:0.1 x:0 y:5 blue:5 spread:10];
    cell.layer.cornerRadius = 12;
    cell.layer.masksToBounds = YES;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.tapItem) {
//        self.tapItem(self.datas[indexPath.item]);
//    }
}

#pragma mark - 自定义滑动位置
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat kMaxIndex = [self.collectionView numberOfItemsInSection:0];;
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
    
    self.pageControl.currentPage = (int)targetIndex % 3;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setupTimer];
}

#pragma mark 子控件滚动
- (void)willBeginDragging{
    [self invalidateTimer];
}

- (void)didEndDragging{
    [self setupTimer];
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
        layout.itemSize = CGSizeMake(self.bounds.size.width - kCellMargin*2, self.bounds.size.height - 30);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 8;
        _layout = layout;
//        layout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 30) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
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

- (HomePageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[HomePageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
        _pageControl.numberOfPages = 3;
    }
    return _pageControl;
}


#pragma mark - NSObject
- (void)layer:(CALayer *)layer applyShadow:(UIColor *)color alpha:(float)alpha x:(CGFloat)x y:(CGFloat)y blue:(CGFloat)blur spread:(CGFloat)spread{
    layer.shadowColor = color.CGColor;
    layer.shadowOpacity = alpha;
    layer.shadowOffset = CGSizeMake(x, y);
    layer.shadowRadius = blur / 2.0;
    if (spread == 0){
        layer.shadowPath = nil;
    } else {
        CGFloat dx = -spread;
        CGRect rect = CGRectInset(layer.bounds, dx, dx);
        layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    }
}
@end
