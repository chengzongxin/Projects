//
//  ViewController.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import <IGListKit/IGListKit.h>
#import "FirstController.h"
#import "SecondController.h"

@interface ViewController ()<IGListAdapterDataSource>


@property (strong, nonatomic) IGListAdapter *adater;
@property (strong, nonatomic) IGListAdapterUpdater *updater;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s",__FUNCTION__);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
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

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[ @"Foo", @"Bar", @42, @"Biz" ];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return [FirstController new];
    } else {
        return [SecondController new];
    }
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
