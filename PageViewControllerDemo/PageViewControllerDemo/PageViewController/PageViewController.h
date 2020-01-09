//
//  PageViewController.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageViewController : UIViewController

#pragma mark - Public 交给子类实现
/** 子类必须实现 */
- (void)setupAllChildViewController;
/** 头部视图,可以不实现 */
- (UIView *)setupHeaderView;

@end

NS_ASSUME_NONNULL_END
