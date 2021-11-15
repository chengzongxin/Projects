//
//  Task3.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "Task3.h"
@interface Task3 ()

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation Task3

- (instancetype)initWithVC:(UIViewController *)VC{
    self = [super init];
    if (!self) { return nil;}
    
    self.vc = VC;
    
    return self;
}

- (void)execute{
    [self showInVC:self.vc delay:0.2 block:^(NSInteger idx) {
        [self finish:@(idx)];
    }];
}

- (void)showInVC:(UIViewController *)vc delay:(int)delay block:(void (^)(NSInteger))block{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"执行操作" message:@"是否执行任务4" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"执行" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(1);
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"跳过" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(2);
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [vc presentViewController:alert animated:YES completion:nil];
    });
}



@end
