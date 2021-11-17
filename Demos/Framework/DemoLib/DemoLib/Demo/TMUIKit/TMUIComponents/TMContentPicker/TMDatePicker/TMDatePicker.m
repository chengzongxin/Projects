//
//  TMDatePicker.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMDatePicker.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"

NSString *const TMDatePickerTitle = @"选择日期";

@interface TMDatePicker()
@property (nonatomic, strong)UIDatePicker *datePickerView;
@property (nonatomic, assign)UIDatePickerMode dateMode;///< 默认为 UIDatePickerModeDate
@end

@implementation TMDatePicker

+ (void)showPickerWithTitle:(NSString *_Nullable)title
                       mode:(TMDatePickerMode)mode
               limitMinDate:(NSDate *_Nullable)minDate
               limitMaxDate:(NSDate *_Nullable)maxDate
                currentDate:(NSDate *_Nullable)currentDate
          finishSelectBlock:(void(^)(NSDate *selectedDate))finishSelectBlock
         fromViewController:(UIViewController *)fromVc {
    
    NSAssert(finishSelectBlock, @"finishSelectBlock can not be nil");
    
    if (!finishSelectBlock) {
        return;
    }
    
    TMDatePicker *picker = [TMDatePicker pickerView];
    picker.title = title ?: TMDatePickerTitle;
    
    //设置系统日期选择器的显示模式
    picker.dateMode = UIDatePickerModeDate;
    if (mode == TMDatePickerModeTime) {
        picker.dateMode = UIDatePickerModeTime;
    }else if (mode == TMDatePickerModeDateAndTime) {
        picker.dateMode = UIDatePickerModeDateAndTime;
    }
    
    [picker loadContentPickerView];
    picker.datePickerView.maximumDate = maxDate;
    picker.datePickerView.minimumDate = minDate;
    if (currentDate) {
        [picker.datePickerView setDate:currentDate];
    }
    
    @TMUI_weakify(picker);
    picker.confirmEventBlockAfterDismiss = ^{
        @TMUI_strongify(picker);
        if (finishSelectBlock) {
            NSDate *date = [picker.datePickerView date];
            finishSelectBlock(date);
        }
    };
    [picker showFromViewController:fromVc];
}

- (void)loadContentPickerView {
    self.datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, TMUI_SCREEN_WIDTH, 216)];
    self.datePickerView.datePickerMode = self.dateMode;
    self.contentView = self.datePickerView;
}

@end
