//
//  CollectionViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/9.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CollectionViewController.h"
#import "PageViewController.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(50, 50);
    PageCollectionView *collectionView = [[PageCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    [self.view addSubview:collectionView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.subviews.firstObject.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    UILabel *label;
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }else{
        label = cell.contentView.subviews.firstObject;
    }
    label.text = @(indexPath.item).stringValue;
    cell.backgroundColor = UIColor.orangeColor;
    return cell;
}

//- (void)scrollViewDidScroll:(PageCollectionView *)scrollView{
//    [scrollView scrollViewDidScroll:scrollView];
//}

@end
