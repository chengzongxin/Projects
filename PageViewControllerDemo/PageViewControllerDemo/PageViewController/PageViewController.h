//
//  PageViewController.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Public 交给子类实现
@protocol PageViewControllerDelegate <NSObject>


@end

@protocol PageViewControllerDataSource <NSObject>

@required
/* 所有子控制器 */
- (NSArray <UIViewController *>*)pageChildViewControllers;

@optional
// 所有子控制器对应的title,默认使用VC.title
- (NSArray <NSString *>*)pageTitles;
// 有头部header时需要实现
- (UIView *)pageHeaderView;

@end

@interface PageViewController : UIViewController<PageViewControllerDataSource,PageViewControllerDelegate,UIPageViewControllerDelegate>
/* 代理方法 */
@property (nullable, nonatomic, weak) id <PageViewControllerDelegate> delegate;
/* 数据源,必须实现 */
@property (nullable, nonatomic, weak) id <PageViewControllerDataSource> dataSource;

@property (nullable, nonatomic, readonly) NSArray<__kindof UIViewController *> *viewControllers;

@end

NS_ASSUME_NONNULL_END
