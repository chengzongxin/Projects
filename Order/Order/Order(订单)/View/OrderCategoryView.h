//
//  OrderCategoryView.h
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBusinessModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderCategoryView : UIView

@property (nonatomic,copy) void (^tapItem)(OrderBusinessModelData *model);

@property (strong, nonatomic) NSArray<OrderBusinessModelData *> *datas;

- (void)show;

- (void)dismiss;

//- (void)loadDatas;

@end

NS_ASSUME_NONNULL_END
