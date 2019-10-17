//
//  OrderCategoryView.h
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderCategoryView : UIView

@property (nonatomic,copy) void (^tapItem)(NSIndexPath *indexPath);

- (void)show;

- (void)dismiss;

- (void)loadDatas;

@end

NS_ASSUME_NONNULL_END
