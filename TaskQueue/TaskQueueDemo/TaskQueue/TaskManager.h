//
//  TaskManager.h
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/19.
//

#import <Foundation/Foundation.h>
#import "TaskOperation.h"

NS_ASSUME_NONNULL_BEGIN

/// 任务调度管理器
@interface TaskManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy, readonly) NSArray *tasks;
@property (nonatomic, assign, readonly) NSInteger taskCount;

- (void)addTask:(TaskOperation *)task;
- (void)removeTask:(TaskOperation *)task;

- (void)start;
- (void)stop;

/// 任务准备就绪
@property (nonatomic, copy) void (^taskReady)(TaskOperation *task);
/// 任务开始执行
@property (nonatomic, copy) void (^taskExecute)(TaskOperation *task);
/// 完成某个任务的回调
@property (nonatomic, copy) void (^taskFinish)(TaskOperation *task);
/// 所有任务完成
@property (nonatomic, copy) void (^taskAllFinish)(void);

@end

NS_ASSUME_NONNULL_END
