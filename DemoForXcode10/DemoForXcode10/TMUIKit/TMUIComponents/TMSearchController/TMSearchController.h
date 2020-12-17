//
//  TMSearchController.h
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/6.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSearchDefines.h"
#import "TMSearchBar.h"
#import "TMSearchingControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN



/**
 @warning 外部不要直接往self.view上添加其它元素，若想添加初始状态时就显示的元素，请将相关子UI添加到self.contentView上
 @warning 当用到searchBar作为其它vc的子视图时，不要用约束指定其显示的位置及尺寸，而应该使用frame来决定其显示效果。否则当点击searchBar后相关UI效果可能会异常.
 */
@interface TMSearchController : UIViewController

/** 模拟的假的导航条视图,高度及位置与真实导航条一致，用于在搜索状态时承载searchBar的显示，显示时search高度会自动调整为44高且底部对齐，左右会撑满
 
 */
@property (nonatomic, strong, readonly)UIView *searchBarContainerView;

/** 用作真实承载其它子vc的view的容器视图
 @note 若外部或子类需要在初始状态时显示一些自定义UI，则可以将相关子UI加载到此视图上，此视图为非全屏高，上面仅靠着导航高度的承载searchBar显示的searchBarContainerView
 */
@property (nonatomic, strong, readonly)UIView *contentView;

@property (nonatomic, strong, readonly)TMSearchBar *searchBar;

@property (nonatomic, strong, readonly, nullable)UIViewController<TMSearchingControllerProtocol> *searchingController;

/** 是否为激活状态，当激活状态时表示处于搜索中效果，即self被present出现显示状态，当为NO时表示外部当前仅显示了searchBar视图
 
 */
@property (nonatomic, assign, getter=isActive)BOOL active;

/** 手动可调用控制激活状态变化，可指定UI是否需要过渡动画效果, 即指定present或dismiss是否展示相关动画效果
 @warning 此接口外部通常情况不会使用
 */
- (void)setActive:(BOOL)active animate:(BOOL)animate;

/**
 vc显示、消失的相关事件回调
 */
@property (nonatomic, copy, nullable)void(^pageEventCallBack)(TMSearchControllerPageEvent pEvent, __kindof TMSearchController *searchController);


#pragma mark - 指定使用此类的唯一初始方法
- (instancetype)initWithSearchingController:(nonnull UIViewController<TMSearchingControllerProtocol> *)searchingController NS_DESIGNATED_INITIALIZER;

#pragma mark - 重新指定以下系统级初始方法为外部不可用
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
