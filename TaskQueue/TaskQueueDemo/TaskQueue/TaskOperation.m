//
//  TaskOperation.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "TaskOperation.h"

/*
 自定义并发的NSOperation
 自定义并发的NSOperation需要以下步骤：
         1.start方法：该方法必须实现，
         2.main:该方法可选，如果你在start方法中定义了你的任务，则这个方法就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定                         义自己的任务
         3.isExecuting  isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
         4.isConcurrent :必须覆盖并返回YES;
 
 */
@interface TaskOperation ()

@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;//判断NSOperation是否执行
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;//判断NSOperation是否结束
@property (nonatomic, readwrite, getter=isCancelled) BOOL canceled;//判断NSOperation是否取消
@property (nonatomic, readwrite, getter=isReady) BOOL ready;//判断NSOperation是否准备

//@property (nonatomic, strong, nullable) id data;
@property (nonatomic, strong, nullable) id finishData;

@end

@implementation TaskOperation

@synthesize executing = _executing;      //指定executing别名为_executing
@synthesize finished = _finished;        //指定finished别名为_finished
@synthesize cancelled = _cancelled;
@synthesize ready = _ready;

#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _executing = NO;
        _finished = NO;
        _canceled = NO;
        _ready = NO;
    }
    return self;
}

#pragma mark - Public

#pragma mark - Main

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@-%@-%@",keyPath,object,change);
    if (change[NSKeyValueChangeNewKey]) {
        [self done]; // 任务执行完成，设置状态，退出任务线程
    }
}

- (void)start{
    
    //第一步就要检测是否被取消了，如果取消了，要实现相应的KVO
    if ([self isCancelled]) {
        [self done];
        return;
    }
    
    self.executing = YES;
    //如果没被取消，开始执行任务
    if ([self executeOnMainThread]) {
        [self performSelectorOnMainThread:@selector(main) withObject:nil waitUntilDone:YES];
    }else{
        [self performSelectorInBackground:@selector(main) withObject:nil];
    }
}

- (void)main{
    @synchronized (self) {
        
        NSLog(@"%@，%@",NSThread.currentThread,self);
        //在这里定义自己的并发任务
        [self execute];
    }
}

#pragma mark - Public
- (void)execute{
    if (self.executeBlock) {
        self.executeBlock();
        return;
    }
    NSAssert(0, @"子类没有实现任务");
}

- (void)finish{
    [self finish:nil];
}

- (void)finish:(id)data{
    self.finishData = data;
    [self done];
}

- (void)skip{
    [self done];
}


#pragma mark - Private
//更新任务状态
- (void)done {
    [super cancel];
    if(_executing) {
        self.finished = YES;
        self.executing = NO;
        [self reset];
    }
}

//重置请求数据
- (void)reset{
    
}

- (BOOL)executeOnMainThread{
    return YES;
}

#pragma mark - Setter & Getter


#pragma mark - setter -- getter

/// 会在一开始加入队列时调用,如果中途修改，需要通知队列
- (void)setReady:(BOOL)isReady{
    [self willChangeValueForKey:@"isReady"];
    _ready = isReady;
    [self didChangeValueForKey:@"isReady"];
}

- (void)setExecuting:(BOOL)executing {
    //调用KVO通知
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    //调用KVO通知
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        !_finishBlock?:_finishBlock(self.finishData);
        [self didChangeValueForKey:@"isFinished"];
    }
}


- (BOOL)isExecuting {
    return _executing;
}


- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isCancelled{
    return _canceled;
}

- (BOOL)isReady{
    return _ready;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isConcurrent{
    return YES;
}


@end



