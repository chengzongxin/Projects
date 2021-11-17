//
//  TMContentPicker.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 内容picker视图的基类，此基类提供通用最全的相关设置和回调
 @note 内部统一相关交互效果，出现：空白背景alpha渐变，整体内容视图底部长到与屏幕底部靠齐，消失：空白背景alpha渐变，整体内容视图下移到屏幕以外
 @note 一般情况下，此基础类没有单独的使用场景。具体场景视图可参见相关子类：TMDatePicker、TMNormalPicker、TMCityPicker、TMMultiDataPicker等
 */
@interface TMContentPicker : UIView

@property (nonatomic, assign)BOOL autoDismissWhenTapBackground;///< 单击背景空白视图j是否自动消失，默认为YES
@property (nonatomic, copy, nullable)NSString *title;///< 标题文字，默认nil

/// 视图将要出现、已经出现(动画过渡完成)、将要消失、已经消失(动画过渡完成)的相关时机事件回调
@property (nonatomic, copy, nullable)void(^willShowBlock)(void);///<将要出现的回调
@property (nonatomic, copy, nullable)void(^didShowBlock)(void);///<视图显示的动画效果完成后的回调
@property (nonatomic, copy, nullable)void(^willDismissBlock)(void);///<视图将要消失的回调
@property (nonatomic, copy, nullable)void(^didDismissBlock)(void);///<视图消失的动画效果完成后的回调

/**
 点击了确定按钮后在视图消失后的事件回调
 @note 此事件回调的顺序在didDismissBlock之后
 */
@property (nonatomic, copy, nullable)void(^confirmEventBlockAfterDismiss)(void);

#pragma mark - 需要指定要展示的具体内容视图对象及内容视图的高度| 把标题栏除开后的下方位置的内容视图，不包括底部安全边距safeArea(iphoneX类似机型时底部会有多空出34的高度)
/**
 需要展示的实际内容视图
 @warning 内部会以此视图现有的size.heigt进行实际高度展示的约束，宽将自适应屏幕宽即保持leading及trailing跟屏幕两边相邻
 */
@property (nonatomic, strong)UIView *contentView;

/// 调用以下显示的方法前，上述属性值应该先被赋值

/**建议外部用此方法生成对应视图对象，外部不用关心此视图对象的frame*/
+ (instancetype)pickerView;

/**外部只需要调用此方法进行展示即可，关闭逻辑由展示后的交互逻辑确定，对外暂不提供主动关闭的接口
 @warning 外部初始化的frame无实际用处,显示时内部逻辑会重新较正
 @note 有过渡动画
 */
- (void)showFromViewController:(UIViewController *)fromVc;

/**
 消失的方法
 @note 有过渡动画
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
