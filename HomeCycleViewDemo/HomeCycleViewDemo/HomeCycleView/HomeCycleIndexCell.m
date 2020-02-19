//
//  HomeCycleIndexCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeCycleIndexCell.h"
#import "IndexListCell.h"

@interface HomeCycleIndexCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation HomeCycleIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.collectionView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 36, self.bounds.size.width, self.bounds.size.height - 36);
    
    _layout.itemSize = CGSizeMake((self.collectionView.frame.size.width - _layout.minimumInteritemSpacing*3) / 3, (self.collectionView.frame.size.height - _layout.minimumInteritemSpacing*2) / 2);
}

#pragma mark CycleCell Delegate
- (void)autoScroll{
    if (self.scrollCount >= (self.datas.count / 6) * 2) {
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
    IndexListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(IndexListCell.class) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectExponentModel:)]) {
        [self.delegate didSelectExponentModel:self.datas[indexPath.item]];
    }
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
        //该方法也可以设置itemSize
        layout.itemSize = self.bounds.size;
        layout.minimumInteritemSpacing = 7;
        layout.minimumLineSpacing = 7;
//        layout.sectionInset = UIEdgeInsetsMake(0, 7, 0, 7);
        _layout = layout;
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.pagingEnabled = YES;
        //        _collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(IndexListCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(IndexListCell.class)];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
