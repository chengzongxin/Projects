//
//  CountrySelectShowView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountrySelectShowView.h"
#import "CountrySelectShowViewCell.h"
#import "UIColor+Utils.h"
@interface CountrySelectShowView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UILabel *selectLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@end

@implementation CountrySelectShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.selectLabel];
        [self addSubview:self.collectionView];
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CountrySelectShowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CountrySelectShowViewCell.class) forIndexPath:indexPath];
    cell.titleLabel.text = _titles[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = _titles[indexPath.item];
    CGFloat width = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width + 10;
    return CGSizeMake(width, 20);
}



#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //不滚动
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置headerView的尺寸大小
        //    ayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 242);
        //    layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 1000);
        //该方法也可以设置itemSize
        CGFloat margin = 10, interval = 10;
        layout.minimumInteritemSpacing = interval;
        layout.minimumLineSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //2.初始化collectionView
        CGRect frame = self.bounds;
        frame.origin.x = 56;
        frame.size.width = self.bounds.size.width - 56 - 68;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CountrySelectShowViewCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CountrySelectShowViewCell.class)];
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

- (UILabel *)selectLabel{
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, self.bounds.size.height)];
        _selectLabel.textColor = [UIColor colorWithHexString:@"#8A98AD"];
        _selectLabel.text = @"已选";
        _selectLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _selectLabel;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(self.bounds.size.width - 68, 0, 68, self.bounds.size.height);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#3B434E"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}

@end
