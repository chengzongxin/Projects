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
#import "ThirdController.h"
//#import "UIScrollView+RefreshController.h"

@interface ViewController ()<IGListAdapterDataSource>


@property (strong, nonatomic) IGListAdapter *adater;
@property (strong, nonatomic) IGListAdapterUpdater *updater;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s",__FUNCTION__);
    
    self.datas = [@[ @"Foo", @"Bar", @42, @"Biz" , [ViewController new]] mutableCopy];
    
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
//    [self.collectionView addRefreshWithHeaderBlock:^{
////        [self.datas addObject:[ViewController new]];
//        ViewController *vc = self.datas.lastObject;
//        vc.view.tag++;
//        [self.adater reloadDataWithCompletion:nil];
//    } footerBlock:^{
//        ViewController *vc = self.datas.lastObject;
//        vc.view.tag++;
//        [self.adater reloadDataWithCompletion:nil];
//    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.frame;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.datas;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return [FirstController new];
    } else if([object isKindOfClass:[NSNumber class]]) {
        return [SecondController new];
    } else {
        return [ThirdController new];
    }
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
