//
//  Task2.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "Task2.h"

@interface Task2 ()

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation Task2

- (instancetype)initWithVC:(UIViewController *)VC{
    self = [super init];
    if (!self) { return nil;}
    
    self.vc = VC;
    
    return self;
}

- (void)execute{
    [self showInVC:self.vc delay:2 block:^(BOOL finished) {
        [self finish];
    }];
}

- (void)showInVC:(UIViewController *)vc delay:(int)delay block:(void (^)(BOOL))block{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    view.backgroundColor = UIColor.orangeColor;
    [vc.view addSubview:view];
    [UIView animateWithDuration:delay animations:^{
        view.frame = CGRectMake(300, 100, 50, 50);
    } completion:^(BOOL finished) {
        block(finished);
        [view removeFromSuperview];
    }];
}
@end
