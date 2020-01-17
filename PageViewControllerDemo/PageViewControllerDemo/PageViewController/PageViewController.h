//
//  PageViewController.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PageTitleConfig;
@protocol PageViewControllerDataSource,PageViewControllerDelegate;
#pragma clang diagnostic push
// To get rid of 'No protocol definition found' warnings which are not accurate
#pragma clang diagnostic ignored "-Weverything"

/* 父类分页控制器 */
@interface PageViewController : UIViewController<PageViewControllerDataSource,PageViewControllerDelegate>
/* 代理方法 */
@property (nullable, nonatomic, weak) id <PageViewControllerDelegate> delegate;
/* 数据源,必须实现 */
@property (nullable, nonatomic, weak) id <PageViewControllerDataSource> dataSource;
/* 子控制器 */
@property (nullable, nonatomic, readonly) NSArray<__kindof UIViewController *> *viewControllers;

@end


#pragma mark - Public 交给子类实现

@protocol PageViewControllerDataSource <NSObject>

@required
/* 所有子控制器,以vc.title作为标题,或者实现pageTitles方法 */
- (NSArray <UIViewController *>*)pageChildViewControllers;

@optional
/* title属性 */
- (PageTitleConfig *)pageTitleConfig;
// 所有子控制器对应的title,默认使用VC.title
- (NSArray <NSString *>*)pageTitles;
// 有头部header时需要实现
- (UIView *)pageHeaderView;

@end

@protocol PageViewControllerDelegate <NSObject>


@end

@interface PageTitleConfig : NSObject
/* 常规字体 */
@property (strong, nonatomic) UIFont *normalFont;
/* 选中字体 */
@property (strong, nonatomic) UIFont *selectedFont;
/* 常规颜色 */
@property (strong, nonatomic) UIColor *normalColor;
/* 选中颜色 */
@property (strong, nonatomic) UIColor *selectedColor;
/* 是否开启渐变动画 */
@property (assign, nonatomic) BOOL gradientsAnimate;

@end


NS_ASSUME_NONNULL_END
