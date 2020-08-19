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
#import "CountryIndexCell.h"
#import "CountrySelectButtonView.h"
#import "CountrySelectShowView.h"
@interface CountrySelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <NSString *>*selectCountries;
@property (strong, nonatomic) CountrySelectButtonView *buttonView;
@property (strong, nonatomic) CountrySelectShowView *showView;

@end

@implementation CountrySelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _selectCountries = [NSMutableArray array];
        [self addSubview:self.showView];
        [self addSubview:self.collectionView];
        [self addSubview:self.tableView];
        [self addSubview:self.buttonView];
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
    [self.tableView reloadData];
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
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
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
    self.showView.titles = _selectCountries;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *country = _data.data.sortAll[indexPath.section].all[indexPath.item].cuntryname;
    [_selectCountries removeObject:country];
    NSLog(@"%@",_selectCountries);
    self.showView.titles = _selectCountries;
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
        layout.itemSize = CGSizeMake(100, 32);
        layout.minimumInteritemSpacing = interval;
        layout.minimumLineSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(10, 25, 10, 25);
        //2.初始化collectionView
        CGRect frame = self.bounds;
        frame.origin.y = 173;
        frame.size.height -= 173;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CountrySelectCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CountrySelectCell.class)];
        [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: NSStringFromClass(UICollectionReusableView.class)];
        _collectionView.contentInset = UIEdgeInsetsMake(32, 0, 60, 0);
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.allowsMultipleSelection = YES;
        
    }
    return _collectionView;
}

#pragma mark UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.data.sortAll.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountryIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CountryIndexCell class])];
    
    NSString *text = _data.data.sortAll[indexPath.row].firstletter;
    if ([text isEqualToString:@"热门国家"]) {
        text = nil;
    }
    cell.titleLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    NSIndexPath *collectionIndexPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.row];
    [_collectionView scrollToItemAtIndexPath:collectionIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}
#pragma mark - Getter TableView
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = self.bounds;
        frame.origin.x = self.bounds.size.width - 30;
        frame.origin.y = self.collectionView.frame.origin.y;
        frame.size.width = 30;
        frame.size.height = 600;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 64;
        // UITableViewStyleGrouped headerView占据35高度
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        // 自适应内容边距
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        // 隐藏下面多出来的cell
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CountryIndexCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CountryIndexCell class])];
    }
    return _tableView;
}

- (CountrySelectButtonView *)buttonView{
    if (!_buttonView) {
        _buttonView = [CountrySelectButtonView xibView];
        _buttonView.frame = CGRectMake(0, self.bounds.size.height - 60, self.bounds.size.width, 60);
        __weak typeof(self) weakSelf = self;
        _buttonView.tapItem = ^(int index) {
            [weakSelf tapItem:index];
        };
    }
    return _buttonView;
}

- (CountrySelectShowView *)showView{
    if (!_showView) {
        _showView = [[CountrySelectShowView alloc] initWithFrame:CGRectMake(0, 123, self.bounds.size.width, 50)];
        __weak typeof(self) weakSelf = self;
        _showView.dismiss = ^{
            [weakSelf dismiss];
        };
    }
    return _showView;
}

- (void)tapItem:(int)index{
    NSLog(@"%d",index);
    if (index == 1) {
        [_collectionView reloadData];
        [_selectCountries removeAllObjects];
        _showView.titles = [_selectCountries copy];
    }else if (index == 2){
        if (self.selectCountriesBlock) {
            self.selectCountriesBlock([_selectCountries copy]);
        }
        [self dismiss];
    }
}

@end
