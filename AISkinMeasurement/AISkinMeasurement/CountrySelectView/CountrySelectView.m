//
//  CountrySelectView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountrySelectView.h"
#import "CountrySelectCell.h"
#import "UIColor+Utils.h"
@interface CountrySelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *selectCountries;

@end

@implementation CountrySelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        _selectCountries = [NSMutableArray array];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setup{
}

#pragma mark - Public
- (void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)setData:(MuseumCountriesModel *)data{
    _data = data;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _data.data.sortAll.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.data.sortAll[section].all.count;
}

//- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(100, 20);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(UICollectionReusableView.class) forIndexPath:indexPath];
        [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 20)];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.text = _data.data.sortAll[indexPath.section].firstletter;
        label.textColor = [UIColor colorWithHexString:@"#2A323E"];
        [view addSubview:label];
        return view;
    }
    return 0;
}

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView{
    NSMutableArray *arr = [NSMutableArray array];
    for (MuseumCountriesModelDataSortAll *sort in _data.data.sortAll) {
        [arr addObject:sort.firstletter];
    }
    return arr;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CountrySelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CountrySelectCell.class) forIndexPath:indexPath];
    cell.textLabel.text = _data.data.sortAll[indexPath.section].all[indexPath.item].cuntryname;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *country = _data.data.sortAll[indexPath.section].all[indexPath.item].cuntryname;
    [_selectCountries addObject:country];
    NSLog(@"%@",_selectCountries);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *country = _data.data.sortAll[indexPath.section].all[indexPath.item].cuntryname;
    [_selectCountries removeObject:country];
    NSLog(@"%@",_selectCountries);
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
        CGFloat margin = 15, interval = 10;
        layout.itemSize = CGSizeMake(100, 32);
        layout.minimumInteritemSpacing = interval;
        layout.minimumLineSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        //2.初始化collectionView
        CGRect frame = self.bounds;
//        frame.size.height = frame.size.height - SafeAreaTopHeight - SafeAreaBottomHeight;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CountrySelectCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CountrySelectCell.class)];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: NSStringFromClass(UICollectionReusableView.class)];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.allowsMultipleSelection = YES;
        
    }
    return _collectionView;
}



@end
