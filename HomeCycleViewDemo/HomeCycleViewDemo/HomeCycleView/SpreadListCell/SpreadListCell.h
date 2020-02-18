//
//  SpreadListCell.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiffPriceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpreadListCell : UICollectionViewCell

@property (nonatomic,strong) DiffPriceModelData *model;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@end

NS_ASSUME_NONNULL_END
