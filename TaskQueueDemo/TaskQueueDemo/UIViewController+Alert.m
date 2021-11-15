//
//  UIViewController+Alert.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/7/5.
//

#import "UIViewController+Alert.h"


@implementation UIViewController (Alert)

- (void)tmui_showAlertWithTitle:(NSString *)title message:(NSString *)message block:(void (^)(NSInteger))block buttons:(NSString *)buttonTitle, ...{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSInteger index = 0;
    va_list args;//定义一个指向个数可变的参数列表指针
    va_start(args, buttonTitle);//得到第一个可变参数地址
    for (NSString *arg = buttonTitle; arg != nil; arg = va_arg(args, NSString *)) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(index);
        }];
        [alert addAction:action];
        index ++;
    }
    va_end(args);//置空指针
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
