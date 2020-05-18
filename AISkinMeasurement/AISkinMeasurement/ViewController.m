//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import <IGListKit/IGListKit.h>

@interface ViewController ()<IGListAdapterDataSource>


@property (strong, nonatomic) IGListAdapter *adater;
@property (strong, nonatomic) IGListAdapterUpdater *updater;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray  *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    [self.view addSubview:self.collectionView];
}

- (void)setupColletionView {
    IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO topContentInset:0 stretchToEdge:NO];
    layout.showHeaderWhenEmpty = NO;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    //    updater.delegate = self;
    IGListAdapter *adater = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    //    adater.delegate = self;
    adater.dataSource = self;
    adater.collectionView = collectionView;
    [self.view addSubview:collectionView];
    self.updater = updater;
    self.adater = adater;
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.frame;
}




#pragma mark IGList DataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.datas;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(NSArray *)object {
    id element = object.firstObject;
    if ([element isKindOfClass:[NSString class]]) {
        return IGListSectionController.new;
    }else{
        return nil;
    }
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        IGListCollectionViewLayout *layout = [[IGListCollectionViewLayout alloc] initWithStickyHeaders:NO topContentInset:0 stretchToEdge:NO];
        layout.showHeaderWhenEmpty = NO;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
        //    updater.delegate = self;
        IGListAdapter *adater = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
        //    adater.delegate = self;
        adater.dataSource = self;
        adater.collectionView = _collectionView;
        self.updater = updater;
        self.adater = adater;
    }
    return _collectionView;
}

@end
