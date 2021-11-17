//
//  ViewController.h
//  Demo
//
//  Created by Joe.cheng on 2020/11/5.
//

#import <UIKit/UIKit.h>
@class THKPageContentViewController;
#import "THKPageBGScrollView.h"
#import "THKSegmentControl.h"
#import "THKViewController.h"

@protocol THKPageContentViewControllerDataSource <NSObject>

@required
/// 返回所有的子VC
- (NSArray <UIViewController *> *)childViewControllers;
/// 返回子VC标题
- (NSArray <NSString *> *)titlesForChildViewControllers;

@optional
/// 固定头部的高度
- (CGFloat)heightForHeader;
/// 固定头部的View
- (UIView *)viewForHeader;
/// 滑动tab的高度
- (CGFloat)heightForSliderBar;
/// 用于自定义配置SliderBar，拿到control后可以设置选中，颜色等tab属性。如果设置frame，heightForSliderBar代理方法无效，注意不要重写UIControlEventValueChanged事件，内部已做滑动交互
- (void)segmentControlConfig:(THKSegmentControl *)control;

@end

@protocol THKPageContentViewControllerDelegate <NSObject>
/// 子VC滑动回调事件
- (void)pageContentViewControllerDidScrolFrom:(NSInteger)fromVC to:(NSInteger)toVC;
/// scrollView滑动回调事件
- (void)pageContentViewControllerDidScroll:(UIScrollView *)scrollView;

@end

@interface THKPageContentViewController : THKViewController <THKPageContentViewControllerDataSource,THKPageContentViewControllerDelegate>
/// 数据源方法，默认Self
@property (nonatomic, weak) id<THKPageContentViewControllerDataSource> dataSource;
/// 代理方法，默认Self
@property (nonatomic, weak) id<THKPageContentViewControllerDelegate> delegate;
/// 当前被选中的indexVC
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/* 组件视图*/
/// 总的背景ScrollView
@property (nonatomic, strong, readonly) THKPageBGScrollView *contentView;
/// 滑动tab
@property (nonatomic, strong, readonly) THKSegmentControl *slideBar;
/// 承载子VC的view的scrollView
@property (nonatomic, strong, readonly) UIScrollView *contentScrollView;
/// 刷新数据源，会初始化所有属性和子视图，重新调代理方法渲染界面
- (void)reloadData;
/// 滑动到某一个子VC
- (void)scrollTo:(UIViewController *)vc;

@end

