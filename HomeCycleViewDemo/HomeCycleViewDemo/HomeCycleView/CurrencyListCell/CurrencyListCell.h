//
//  CurrencyListCell.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotSymbolModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CurrencyListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *increaseLabel;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic,strong) HotSymbolModelData *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *symbolWidth;

@end

NS_ASSUME_NONNULL_END
