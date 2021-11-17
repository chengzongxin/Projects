//
//  TMDatePicker.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMContentPicker.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const TMDatePickerTitle;

typedef NS_ENUM(NSInteger, TMDatePickerMode) {
    TMDatePickerModeDate = 0,       ///< 年-月-日
    TMDatePickerModeTime,           ///< 时-分-秒
    TMDatePickerModeDateAndTime,    ///< 年-月-日-时-分-秒
};

/**日期选择器
 */
@interface TMDatePicker : TMContentPicker


/// 日期选择器初始化及UI显示的便捷方法
/// @param title 选择器顶部的title串, 若为nil，则会取默认的title - 选择日期
/// @param mode 对应日期选择器的模式，可指定年-月-日 或  时-分-秒 或 年-月-日-时-分-秒
/// @param minDate  限制选择的日期范围最小值，若为nil表示不做限制
/// @param maxDate 限制选择的日期范围最大值，若为nil表示不做限制
/// @param currentDate 指定初始化后显示到的日期，若为nil会默认显示成今天的日期
/// @param finishSelectBlock 当点击确定按钮后，等视图完全消失后的业务数据回调
/// @param fromVc 需要选择present的vc，内部统一处理为用fromVc.tabbarController作present操作
+ (void)showPickerWithTitle:(NSString *_Nullable)title
                       mode:(TMDatePickerMode)mode
               limitMinDate:(NSDate *_Nullable)minDate
               limitMaxDate:(NSDate *_Nullable)maxDate
                currentDate:(NSDate *_Nullable)currentDate
          finishSelectBlock:(void(^)(NSDate *selectedDate))finishSelectBlock
         fromViewController:(UIViewController *)fromVc;

@end

NS_ASSUME_NONNULL_END
