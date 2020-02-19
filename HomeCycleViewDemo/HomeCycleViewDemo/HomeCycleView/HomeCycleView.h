//
//  HomeCycleView.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/14.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiffPriceModel.h"
#import "HotSymbolModel.h"
#import "ExponentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCycleView : UIView

@property (nonatomic,strong) DiffPriceModelData *diffPriceData;

@property (nonatomic,strong) HotSymbolModelData *hotSymbolData;

@property (nonatomic,strong) ExponentModelData *exponentData;

- (void)didSelectModel:(void (^)(DiffPriceModelData *model))diffPriceBlock hotSymbolBlock:(void (^)(HotSymbolModelData *model))hotSymbolBlock exponentBlock:(void (^)(ExponentModelData *model))exponentBlock;

@end

NS_ASSUME_NONNULL_END
