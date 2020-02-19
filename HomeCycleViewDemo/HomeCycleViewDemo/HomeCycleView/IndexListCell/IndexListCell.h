//
//  IndexListCell.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExponentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface IndexListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *increaseLabel;

@property (nonatomic,strong) ExponentModelData *model;

@end

NS_ASSUME_NONNULL_END
