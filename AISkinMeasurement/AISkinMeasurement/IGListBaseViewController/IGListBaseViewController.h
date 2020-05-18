//
//  IGListBaseViewController.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGListBaseViewController : UIViewController<IGListAdapterDataSource>


@property (strong, nonatomic) IGListAdapter *adater;
@property (strong, nonatomic) IGListAdapterUpdater *updater;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray  *datas;

@end

NS_ASSUME_NONNULL_END
