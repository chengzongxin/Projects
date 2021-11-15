//
//  BaseTask.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/19.
//

#import "BaseTask.h"
#import "UIViewController+Alert.h"

@implementation BaseTask


- (void)requestDelay:(int)delay block:(netBlock)block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)request:(netBlock)block{
    block();
}

- (void)showInVC:(UIViewController *)vc block:(void (^)(NSInteger))block{
    [vc tmui_showAlertWithTitle:@"alert" message:NSStringFromClass(self.class) block:^(NSInteger index) {
        block(index);
    } buttons:@"Confirm",@"cancel"];
}

- (void)showInVC:(UIViewController *)vc delay:(int)delay block:(void (^)(NSInteger))block{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSStringFromClass(self.class) message:@"task start" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        [alert addAction:action];
        [vc presentViewController:alert animated:YES completion:nil];
    });
}

@end
