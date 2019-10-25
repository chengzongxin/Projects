//
//  OrderCategoryView.m
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "OrderCategoryView.h"
#import "OrderCategoryCell.h"

@interface OrderCategoryView ()<UICollectionViewDelegate,UICollectionViewDataSource>

//@property (strong, nonatomic) NSArray *datas;
@property (strong, nonatomic) UIVisualEffectView *blurView;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation OrderCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 毛玻璃效果
        [self addSubview:self.blurView];
        // 列表
        [self addSubview:self.collectionView];
        
        self.hidden = YES;
    }
    return self;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    self.blurView.frame = self.bounds;
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, 128);
}

#pragma mark - Public
//- (void)loadDatas{
//    self.datas = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
//
//    [self.collectionView reloadData];
//
//    if (self.datas.count == 0) {
//        return;
//    }
//
//    [self selectFirstCell];
//
//    CGFloat height = [self caculateCollectionViewHeight];
//    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
//}

- (void)setDatas:(NSArray<OrderBusinessModelData *> *)datas{
    _datas = datas;
    
    [self.collectionView reloadData];
    
    if (self.datas.count == 0) {
        return;
    }
    
    [self selectFirstCell];
    
    CGFloat height = [self caculateCollectionViewHeight];
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
}

- (void)show{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.collectionView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)dismiss{
    self.hidden = YES;
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.collectionView.transform = CGAffineTransformScale(self.transform, 1, 0);
    } completion:nil];
}

#pragma mark - Delegate
#pragma mark UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OrderCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OrderCategoryCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.datas[indexPath.item].name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tapItem) {
        self.tapItem(self.datas[indexPath.item]);
    }
}


#pragma mark - Private
// MARK: 选中第一个
- (void)selectFirstCell{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];//设置第一行
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
}

// MARK: 计算高度
- (CGFloat)caculateCollectionViewHeight{
    NSInteger numberOfItem = [self collectionView:self.collectionView numberOfItemsInSection:0] - 1;
    if (numberOfItem <= 0) {
        NSLog(@"没有数据");
        return 128;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:numberOfItem inSection:0];
    UICollectionViewLayoutAttributes *attr = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGFloat maxY = CGRectGetMaxY(attr.frame);

    return maxY+16;
}

#pragma mark - Getter

- (UIVisualEffectView *)blurView{
    if (!_blurView) {
        // 毛玻璃效果
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _blurView.alpha = 0.9;
    }
    return _blurView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //不滚动
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        //        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 242);
        //    layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 1000);
        //该方法也可以设置itemSize
        layout.itemSize = CGSizeMake(80, 30);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCategoryCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([OrderCategoryCell class])];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
