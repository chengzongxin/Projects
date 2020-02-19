//
//  HomeCycleSpreadCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeCycleSpreadCell.h"
#import "SpreadListCell.h"

@interface HomeCycleSpreadCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation HomeCycleSpreadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.collectionView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    _layout.itemSize = self.bounds.size;
}

#pragma mark CycleCell Delegate
- (void)autoScroll{
    if (self.scrollCount >= self.datas.count * 2) {
        self.scrollCount = 0;
        if ([self.delegate respondsToSelector:@selector(scrollOver)]) {
            [self.delegate scrollOver];
            return;
        }
    }
    [self.collectionView scrollToNextItem];
    self.scrollCount++;
}

#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SpreadListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SpreadListCell.class) forIndexPath:indexPath];
    
    cell.model = self.datas[indexPath.item];
    
    return cell;
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
        layout.itemSize = self.bounds.size;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        //        layout.sectionInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        _layout = layout;
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.pagingEnabled = YES;
//        _collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SpreadListCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(SpreadListCell.class)];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
