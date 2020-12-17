//
//  TMContentAlert.h
//  HouseKeeper
//
//  Created by nigel.ning on 2020/4/13.
//  Copyright © 2020 binxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**用于辅助一些内容视图的弹框视图进行展示的工具类
 @note 一般在当前vc下若需要弹出一个非全屏内容视图展示时，若当前内容视图已定义为view，则可调用此类相关方法进行统一的显示或消失的相关逻辑处理
 */
@interface TMContentAlert : NSObject


/// 调用此方法进行指定contentView的显示操作
/// @param fromVc 内部执行present参考的vc，内部会统一判断优先取tabbarController或navigationController
/// @param block 可以将需要展示的视图添加到此回调的toShowVc.view上，此vc对应view尺寸为屏幕尺寸，默认视图背景色为透明色，外部可根据实际场景需要调整相关显示效果
/// @param didShowBlock 当内容present操作完成后的回调
/// @warning 内部实现为直接present 无动画效果,若需要内容视图出现时有动画效果，需要自行在block里作视图相关初始值调整，在didShowBlock开启相关显示的动画效果
+ (void)showFromViewController:(UIViewController *)fromVc
               loadContentView:(void(^)(__kindof UIViewController *toShowVc))block
                  didShowBlock:(void(^_Nullable)(void))didShowBlock;


/// 调用此方法进行指定contentView的隐藏操作
/// @param contentView 调用上面的show方法时传入的内容视图
/// @param didHiddenBlock 内部执行完dismiss操作后的回调
/// @warning 内部实现为直接dismiss 无动画效果，若需要内容视图消失时有动画效果，需要自行在外部作动画，当动画完成后再调用此函数来进行真实的hidden操作
/// @warning 此方法与上面show方法必须配套使用，一个管显示处理逻辑，一个管隐藏处理逻辑
+ (void)hiddenContentView:(UIView *)contentView didHiddenBlock:(void(^_Nullable)(void))didHiddenBlock;

@end

NS_ASSUME_NONNULL_END
