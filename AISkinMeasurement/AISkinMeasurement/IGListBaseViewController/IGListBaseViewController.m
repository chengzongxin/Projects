//
//  ViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "IGListBaseViewController.h"

@interface IGListBaseViewController ()

@end

@implementation IGListBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.frame;
}


#pragma mark IGList DataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.datas;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return IGListSectionController.new;
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
