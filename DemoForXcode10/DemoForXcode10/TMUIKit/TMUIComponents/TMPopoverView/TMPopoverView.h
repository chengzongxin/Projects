//
//  TMPopoverView.h
//  Masonry
//
//  Created by nigel.ning on 2020/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MASConstraintMaker;

/// 定义箭头的朝向
/// 箭头向下，内容显示在箭头上方；箭头向上，内容显示在箭头下方；箭头向左，内容显示在箭头右侧；箭头向右，内容显示在箭头左侧


typedef NS_ENUM(NSUInteger, TMPopoverArrowDirection) {
    TMPopoverArrowDirectionUp = 0,
    TMPopoverArrowDirectionDown,
    TMPopoverArrowDirectionLeft,
    TMPopoverArrowDirectionRight,
};

/**
 提供类似系统UIPopoverController的显示效果的视图类
 @note 通常可用于显示带箭头指示的浮层菜单项视图或带箭头指示的简单的引导视图
 @note 内部的显示是将此视图加到delegate.window的适合位置上。内部根据相关参数自动处理显示位置及显示尺寸,外部使用时只需要指定传入的contentView视图的尺寸或尺寸约束即可。
 */
@interface TMPopoverView : UIView

@property (nonatomic, strong)UIColor *maskBackgroundColor;///< 底部蒙层视图的颜色，默认为clearColor

@property (nonatomic, strong)UIColor *popoverBackgroundColor;///< 弹出视图的背景色，默认为 353535 | show方法调用之前赋值有效

@property (nonatomic, assign)UIEdgeInsets popoverLayoutMargins;///< popover视图显示的四周的安全边距，默认为{top: tmui_safeAreaTopInset(), left: 10, bottom: tmui_safeAreaBottomInset(), right: 10} | show方法调用之前赋值有效

/** 箭头在可以显示为默认居中效果的前提下，可额外指定相对中间位置的偏移值(当箭头显示方向为上或下时，此值影响横坐标方向，正值为中间位置再向右偏移，负值则中间位置再向左偏移；当箭头显示方向为左或右时，此值影响纵坐标方向，正值为中间位置再向下偏移，负值则中间位置再向上偏移)
 @warning 注意合理给值，若给的值经过约束计算后的显示位置超出实际展示的区域，则可能造成UI显示异常
 @note 默认为 0，即当内容显示后，箭头有条件居中显示则居中显示
 */
@property (nonatomic, assign)CGFloat arrowCenterOffset;

/**
 显示的箭头尺寸，以正向的三角型尺寸赋值，即底边为宽，高度为三角型的高，默认为{6, 4}
 @note 若箭头朝向为上或下，则底边为宽，三角型高为高| 若箭头朝向为左或右则宽高互换
 */
@property (nonatomic, assign)CGSize arrowSize;

@property (nonatomic, assign)BOOL autoDismissWhenTouchOutSideContentView;///< 当点击了contentView之外的空白区域时是否自动消失，默认为YES 

#pragma mark - init methods

/**当外部明确指定显示的内容视图的size大小时，可使用此方法初始化popoverview视图*/
+ (instancetype)popoverViewWithContentView:(UIView *)contentView contentSize:(CGSize)size;

/**当外部不明确内容视图尺寸，相关布局尺寸约束由内容视图内部子视图相关约束来保持显示效果时，可使用此方法初始化popoverview视图。 在block里对make的width及Height根据实际情况进行适应的赋值，若内容视图内部子视图的约束已能很好的保证显示效果，则此block则指定为nil*/
+ (instancetype)popoverViewWithContentView:(UIView *)contentView layoutContentViewSize:(void(^_Nullable)(MASConstraintMaker *make))contentSizeMakeBlock;

#pragma mark - show methods
/**一般情况下在点击了导航条上的item视图后需要显示Popover视图时可用此便捷方法，相关箭头即指向对应的item视图对位
 @note 通常导航条的direction给up；底部toolbar时direction给down.
 @warning ⚠️⚠️⚠️ 此接口参数arrowDirection约定限定为up/down 两种
 */
- (void)showFromBarButtonItem:(UIBarButtonItem *)barItem arrowDirection:(TMPopoverArrowDirection)arrowDirection;

/**当点击了页面其它位置的按钮时，若需要显示popover视图时可用此方法，相关箭头指向外部可根据真实实况给定合适的值
 @note 一般情况 箭头向下，显示在视图上方；箭头向上，显示在视图下方；箭头向左，显示在视图右方；箭头向右，显示在视图左方
 @warning 若view为nil则不会显示
 @warning ⚠️⚠️⚠️ 传入的位置参数与arrowDirection要确实合适，否则可能会报内部视图的约束警告
 @warning ⚠️⚠️⚠️传入的rectr和view是为了方便内部计算出合适的显示位置，但不是显示在view上，而是直接显示在当前AppDelegate的window上
 */
- (void)showFromRect:(CGRect)rect inView:(UIView *)view
      arrowDirection:(TMPopoverArrowDirection)arrowDirection;

#pragma mark - dismiss methods

/**
 消失隐藏
 */
- (void)dismiss;

/**
 消失隐藏并在消失后执行回调
 */
- (void)dismissWithFinishBlock:(void(^_Nullable)(void))dismissFinishBlock;

@end

/**方便从popoverView的contentView或contentView的任一子视图获取其所在的popoverView实例
 */
@interface UIView(TMPopoverView)

/**外部仅在需要的时候关注此值的读取即可，相关赋值逻辑在TMPopoverView的内部处理逻辑会赋值
 @note 当popoverView的contentView或contentView的任一子视图调用此属性值均能正常返回其显示所属的poperView实例
 @warning 若是非popoverView的contentView及其子视图对象调用此方法，则内部实现会向上逐级遍历父视图并查询对应的缓存数据，若无则返回nil
 @warning ⚠️⚠️⚠️ view.tmui_popoverView表示的是view为对应popoverView中的contentView或contentView的子视图,  【重要】：切忌不要认为其表示显示在view上的popoverView视图
 */
@property (nonatomic, nullable, weak)TMPopoverView *tmui_popoverView;

@end

NS_ASSUME_NONNULL_END
