//
//  HomeCycleCurrencyCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomeCycleCurrencyCell.h"
#import "CurrencyListCell.h"

@interface HomeCycleCurrencyCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation HomeCycleCurrencyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.collectionView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    _layout.itemSize = CGSizeMake(self.bounds.size.width / 2, self.bounds.size.height);
}

#pragma mark CycleCell Delegate
- (void)autoScroll{
    [self.collectionView scrollToNextItem];
}
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CurrencyListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CurrencyListCell.class) forIndexPath:indexPath];
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
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CurrencyListCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CurrencyListCell.class)];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)setDatas:(NSArray *)datas{
    [super setDatas:datas];
}

@end
