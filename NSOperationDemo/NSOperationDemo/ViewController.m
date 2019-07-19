//
//  ViewController.m
//  NSOperationDemo
//
//  Created by Joe on 2019/7/5.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

@end

@implementation ViewController


/**
 * 使用子类 NSInvocationOperation
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self useInvocationOperation];
    // 在其他线程使用子类 NSInvocationOperation
//    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];
    
//    [self useBlockOperation];
    
//    [self useBlockOperationAddExecutionBlock];
    
//    [self addOperationToQueue];
    
//    [self setMaxConcurrentOperationCount];
    
//    [self addDependency];
    
//    [self operationPriority];
    
//    [self communication];
    
//    [self customOperation];
    
    [self queueSuspend];
}

- (void)queueSuspend{
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"q1-time:%d--%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"q2-time:%d--%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    
    op1.queuePriority = NSOperationQueuePriorityVeryLow;
    op2.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    queue1.qualityOfService = NSQualityOfServiceDefault;
    queue2.qualityOfService = NSQualityOfServiceUserInteractive;
    
    queue1.suspended = YES;
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        queue1.suspended = NO;
    });
}

/**
 自定义线程
 */
- (void)customOperation {
    NSString *imgUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562612860471&di=c9732b1711ca76dd8ee9155e230ebf10&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20190615%2Fce0b3c83f12a4a119ca9a63d3a2c0ae5.jpeg";
    
    DownloadOperation *op = [DownloadOperation downloadImageWithURLString:imgUrl andFinishBlock:^(UIImage * _Nonnull img) {
        UIImageView *imgv = [[UIImageView alloc] initWithImage:img];
        imgv.frame = self.view.bounds;
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imgv];
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:op];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [op cancel];
        
        //        [queue cancelAllOperations];
    });
}

/**
 * 线程间通信
 */
- (void)communication {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

- (void)operationPriority{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op1 addDependency:op2];
    [op2 addDependency:op3];
    
    op1.queuePriority = NSOperationQueuePriorityVeryHigh;
    op2.queuePriority = NSOperationQueuePriorityHigh;
    op3.queuePriority = NSOperationQueuePriorityVeryLow;
    op4.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
}

- (void)addDependency{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op2 addDependency:op1];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}

/**
 * 设置 MaxConcurrentOperationCount（最大并发操作数）
 */
- (void)setMaxConcurrentOperationCount {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发操作数
    queue.maxConcurrentOperationCount = 1; // 串行队列
    // queue.maxConcurrentOperationCount = 2; // 并发队列
    // queue.maxConcurrentOperationCount = 8; // 并发队列
    
    // 3.添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 * 使用 addOperation: 将操作加入到操作队列中
 */
- (void)addOperationToQueue{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发操作数
//    queue.maxConcurrentOperationCount = 1; // 串行队列
     queue.maxConcurrentOperationCount = 2; // 并发队列
    // queue.maxConcurrentOperationCount = 8; // 并发队列
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 * 使用子类 NSBlockOperation
 * 调用方法 AddExecutionBlock:
 */
- (void)useBlockOperationAddExecutionBlock {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 2.添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"7---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"8---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.调用 start 方法开始执行操作
    [op start];
}


/**
 * 使用子类 NSBlockOperation
 */
- (void)useBlockOperation{
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    // 2.调用 start 方法开始执行操作
    [op start];
}



/**
 * 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {
    
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    
    // 2.调用 start 方法开始执行操作
    [op start];
}


- (void)task{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)task1{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)task2{
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
    }
}

@end
