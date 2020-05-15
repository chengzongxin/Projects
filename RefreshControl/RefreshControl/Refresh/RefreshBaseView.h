//
//  RefreshBaseView.h
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshConstant.h"
#import "UIView+Layout.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    
    RefreshStatusNormal = 1,  // 正常状态
    
    RefreshStatusPrepareRefresh = 2, // 准备刷新
    
    RefreshStatusRefreshing = 4,  // 正在刷新
    
    RefreshStatusFinish = 8, // 刷新完成
    
    RefreshStatusLoadAll = 16, // 加载完所有
    
} RefreshStatus;

/** 进入刷新状态的回调 */
typedef void (^RefreshingBlock)(void);

@interface RefreshBaseView : UIView

#pragma mark - 交给子类去访问
@property (assign, nonatomic) RefreshStatus status;

@property (nonatomic,strong) UIScrollView   *superScrollView;   //父视图（表格scrollView）

@property (readonly,assign, nonatomic) UIEdgeInsets  orginScrollViewContentInset;   // 原始内容缩进

@property (nonatomic,assign) CGFloat        superScrollViewContentOffY;        //父视图的偏移量

@property (nonatomic,assign) CGSize         superScrollViewContentSize;        //父视图的大小

@property (weak, nonatomic) id target;

@property (assign, nonatomic) SEL selector;

@property (copy, nonatomic) RefreshingBlock refreshingBlock;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

#pragma mark - 交给子类们去实现
// 初始化工作
- (void)prepare;
// 布局子控件
- (void)placeSubviews;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
// 开始刷新
- (void)startRefresh;
// 结束刷新
- (void)stopRefresh;
@end

NS_ASSUME_NONNULL_END
