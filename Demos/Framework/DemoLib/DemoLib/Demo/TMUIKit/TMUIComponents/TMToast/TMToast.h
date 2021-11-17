//
//  TMToast.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 当传入的str为nil或为空串时，将不作显示
 */
@interface TMToast : NSObject

@property (nonatomic, assign, class)NSTimeInterval duration;///< 视图出现后存在的时长，默认1秒，1秒后视图会自动消失| 影响全局toast显示时长,尽量不修改此值

/**统一在顶部位置，动画过渡显示最后自动渐变消失，存在时长1秒
 @param str 显示的文本
 @warning 显式1行，超出...
 */
+ (void)toast:(NSString *)str;

/**扩展方法，支持直接传入富文本串
 @param attrStr 显示的副文本
 @warning 显式1行，超出...
 */
+ (void)toastAttributedString:(NSAttributedString *)attrStr;

#pragma mark - 针对一些特殊场景需要自定义显示的时长及消失后的回调提供支持


/** 可指定显示时长及隐藏后的回调
 @param str 要显示的文本
 @param delay 要指定的显示时长，此时长过后会自动隐藏
 @param block 自动隐藏完成后的回调
 @warning 若delay为0 则会取默认的  duration 值，1秒
 */
+ (void)toast:(NSString *)str hideAfterDelay:(NSTimeInterval)delay hideFinishBlock:(void(^_Nullable)(void))block;

/** 可指定显示时长及隐藏后的回调
@param attrStr 要显示的富文本
@param delay 要指定的显示时长，此时长过后会自动隐藏
@param block 自动隐藏完成后的回调
@warning 若delay为0 则会取默认的  duration 值，1秒
*/
+ (void)toastAttributedString:(NSAttributedString *)attrStr hideAfterDelay:(NSTimeInterval)delay hideFinishBlock:(void(^_Nullable)(void))block;

@end

@interface TMToast(ScoreToast)

/**
 显示加兔币积分的提示视图的扩展方法
 @warning 若content串长度为0，则不会显示toast
 @warning 若score<=0，则内部按普通toast样式显示，仅显示content内容
 */
+ (void)toastScore:(NSInteger)score content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
