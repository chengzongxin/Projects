//
//  TaskManager.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/19.
//

#import "TaskManager.h"

@interface TaskManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) NSMapTable *taskMap;
@property (nonatomic, strong) NSMapTable *removeTaskMap;


@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation TaskManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self didInitalize];
    }
    return self;
}

- (void)didInitalize{
    
}

#pragma mark - Public
- (void)start{
    self.queue.suspended = NO;
    [self startNextTask];
}

- (void)stop{
    [self.taskArray removeAllObjects];
    [self.queue cancelAllOperations];
    self.queue.suspended = YES;
}

- (void)addTask:(TaskOperation *)task{
    [self.taskArray addObject:task];
}

- (void)removeTask:(TaskOperation *)task{
    [self.taskArray removeObject:task];
}

- (void)addObserver:(TaskOperation *)taskOperation{
    [taskOperation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [taskOperation addObserver:self forKeyPath:@"isReady" options:NSKeyValueObservingOptionNew context:nil];
    [taskOperation addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserver:(TaskOperation *)taskOperation{
    [taskOperation removeObserver:self forKeyPath:@"isFinished"];
    [taskOperation removeObserver:self forKeyPath:@"isReady"];
    [taskOperation removeObserver:self forKeyPath:@"isExecuting"];
//    [self startNextTask];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(TaskOperation *)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@-%@-%@",keyPath,object,change);
    if ([keyPath isEqualToString:@"isFinished"]) {
        !_taskFinish?:_taskFinish(object);
        int newValue = [change[NSKeyValueChangeNewKey] intValue];
        if (newValue) {
            [self removeObserver:object];
            [self startNextTask];
        }
    }else if ([keyPath isEqualToString:@"isReady"]) {
        !_taskReady?:_taskReady(object);
    }else if ([keyPath isEqualToString:@"isExecuting"]) {
        !_taskExecute?:_taskExecute(object);
    }else{
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)startNextTask{
    TaskOperation *task = self.taskArray.firstObject;
//    TaskOperation *task = self.queue.operations.firstObject;
    if (task) {
        // 有任务
        if (task.isReady == NO && task.isExecuting == NO) {
            [self addObserver:task];
            [self.queue addOperation:task];
            [task setReady:YES];
            [self.taskArray removeObject:task];
        }else{
            NSLog(@"task is execute, %@",task);
        }
    }else{
        // 没有任务
        [self stop];
        !_taskAllFinish?:_taskAllFinish();
    }
}

- (void)dealloc{
//    [self removeObserver:self forKeyPath:@"model.status"];
}


#pragma mark - Setter & Getter

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = NSOperationQueue.new;
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}

- (NSMapTable *)taskMap{
    if (!_taskMap) {
        _taskMap = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    return _taskMap;
}

- (NSMapTable *)removeTaskMap{
    if (!_removeTaskMap) {
        _removeTaskMap = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    }
    return _removeTaskMap;
}

- (NSMutableArray *)taskArray{
    if (!_taskArray) {
        _taskArray = [NSMutableArray array];
    }
    return _taskArray;
}

- (NSInteger)taskCount{
    return self.taskArray.count;
}

- (NSArray *)tasks{
    return self.taskArray.copy;
}


@end
