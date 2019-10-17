//
//  OrderListBaseViewController.h
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *datas;

@end

NS_ASSUME_NONNULL_END
