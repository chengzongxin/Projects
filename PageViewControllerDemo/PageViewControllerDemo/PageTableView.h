//
//  PageTableView.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/8.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageTableView : UITableView<UIGestureRecognizerDelegate>
/* 滑动联动,有头部视图时候必须实现 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
