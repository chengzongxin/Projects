//
//  UIViewController+Alert.h
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Alert)

- (void)tmui_showAlertWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))block buttons:(NSString *)buttonTitle, ...;

@end

NS_ASSUME_NONNULL_END
