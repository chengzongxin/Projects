//
//  TaskOperation.h
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class TaskOperation;
@protocol TaskOperationDelegate <NSObject>

- (void)taskDidFinish:(TaskOperation *)task;

@end

/*
 有两种使用方式：
 1. 直接创建task，并添加到任务管理器中，实现executeBlock，完成后再调用finish
    ···
 TaskOperation *task4 = [[TaskOperation alloc] init];
 __weak __typeof(task4)wt4 = task4;
 task4.executeBlock = ^{
     NSLog(@"task4 exeuting...");
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         NSLog(@"task4 finish");
         self.view.backgroundColor = UIColor.whiteColor;
         [wt4 finish];
     });
 };
 [TaskManager.sharedInstance addTask:task4];
 ···
 2. 创建TaskOperation的子类使用，在子类中重写execute方法，实现业务逻辑，最后调用finish
    ···
 - (void)execute{
     [UIView animateWithDuration:1 animations:^{
         self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
         
     }completion:^(BOOL finished) {
         [self finish];
     }];
 }
 ···
 */
@interface TaskOperation : NSOperation

@property (nonatomic, weak) id<TaskOperationDelegate> delegate;

@property (nonatomic, strong, readonly) id finishData;

/// 任务准备执行
- (void)setReady:(BOOL)isReady;
/// 跳过
- (void)skip;

/// 任务block，直接在内部实现业务
@property (nonatomic, copy) void (^executeBlock)(void);
/// 完成block，任务完成后会回调
@property (nonatomic, copy) void (^finishBlock)(_Nullable id data);

#pragma mark - 子类重写、调用
/// 主要执行任务，需要重写这个方法，在实现方法中实现业务逻辑，完成后需要主动调用finish方法
- (void)execute;
/// 完成任务，子类调用后表示当前任务已完成，开始下一个任务
- (void)finish;
- (void)finish:(nullable id)data;
/// 任务清理，执行完成后，需要清理的操作
- (void)reset;
/// 是否在主线程执行,默认是在主线程，可以重写返回NO，在子线程执行，提高性能，但是刷新UI必须在主线程
- (BOOL)executeOnMainThread;

@end

NS_ASSUME_NONNULL_END
