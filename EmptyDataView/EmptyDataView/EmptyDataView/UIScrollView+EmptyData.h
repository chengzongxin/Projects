//
//  UIScrollView+EmptyData.h
//  EmptyDataView
//
//  Created by Joe on 2019/8/22.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (EmptyData)

- (void)loadingDataView;
- (void)emptyDataView;
- (void)errorDataView;

@end

NS_ASSUME_NONNULL_END
