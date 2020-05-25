//
//  PageViewController.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
// 所有依赖头文件
#import "UIViewController+Page.h"
#import "PageTableView.h"
#import "PageCollectionView.h"

NS_ASSUME_NONNULL_BEGIN
@class PageConfig;
@protocol PageViewControllerDataSource,PageViewControllerDelegate;
#pragma clang diagnostic push
// To get rid of 'No protocol definition found' warnings which are not accurate
#pragma clang diagnostic ignored "-Weverything"

/* 父类分页控制器 */
@interface PageViewController : UIViewController<PageViewControllerDataSource,PageViewControllerDelegate>
/* 代理方法,代理默认为自己(当前VC) */
@property (nullable, nonatomic, weak) id <PageViewControllerDelegate> delegate;
/* 数据源,必须实现,数据源默认为自己(当前VC) */
@property (nullable, nonatomic, weak) id <PageViewControllerDataSource> dataSource;
/* 子控制器 */
@property (nullable, nonatomic, readonly) NSArray<__kindof UIViewController *> *viewControllers;
// 滑动到某个ViewController
- (void)scrollToIndex:(NSInteger)index animate:(BOOL)animate;

@end


#pragma mark - Public 交给子类实现

@protocol PageViewControllerDataSource <NSObject>

@required
/* 所有子控制器,以vc.title作为标题,或者实现pageTitles方法 */
- (NSArray <UIViewController *>*)pageChildViewControllers;

@optional
/* title属性 */
- (PageConfig *)pageConfig;
// 所有子控制器对应的title,默认使用VC.title
- (NSArray <NSString *>*)pageTitles;
// 有头部header时需要实现
- (UIView *)pageHeaderView;

@end

@protocol PageViewControllerDelegate <NSObject>

- (void)pageViewController:(PageViewController *)pageViewController didScroll:(UIScrollView *)scrollView;

- (void)pageViewController:(PageViewController *)pageViewController didSelectWithIndex:(NSInteger)index;

@end

@interface PageConfig : NSObject
/* 默认方法 */
+ (instancetype)config;
/* 分类菜单尺寸 */
@property (assign, nonatomic) CGSize pageMenuSize;
/* 常规字体 */
@property (strong, nonatomic) UIFont *itemNormalFont;
/* 选中字体 */
@property (strong, nonatomic) UIFont *itemSelectedFont;
/* 常规颜色 */
@property (strong, nonatomic) UIColor *itemNormalColor;
/* 选中颜色 */
@property (strong, nonatomic) UIColor *itemSelectedColor;
/* 常规 */
@property (strong, nonatomic) UIImage *itemNormalImage;
/* 选中 */
@property (strong, nonatomic) UIImage *itemSelectedImage;
/* 是否开启item颜色混合渐变动画 */
@property (assign, nonatomic) BOOL itemGradientsAnimate;
/* 跟踪器是否隐藏 */
@property (nonatomic, assign)  CGFloat trackerHidden;
/* 跟踪器宽度,默认和字体等宽 */
@property (nonatomic, assign)  CGFloat trackerWidth;
/* 跟踪器宽度,默认3 */
@property (nonatomic, assign)  CGFloat trackerHeight;
/* 跟踪器额外宽度,默认多6个宽度 */
@property (nonatomic, assign)  CGFloat trackerWidthAdditional;
/* 下划线滑动样式,依恋样式 */
@property (assign, nonatomic) BOOL trackerNotAttachmentStyle;

@end


NS_ASSUME_NONNULL_END
