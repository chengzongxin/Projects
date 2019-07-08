//
//  DownloadOperation.m
//  NSOperationDemo
//
//  Created by Joe on 2019/7/9.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import "DownloadOperation.h"

@interface DownloadOperation ()

/**
 图片地址
 */
@property(copy,nonatomic) NSString *urlString;

/**
 回调Block,在主线程执行
 */
@property(copy,nonatomic) void(^finishBlock)(UIImage *);


@end

@implementation DownloadOperation


/**
 重写自定义操作的入口方法
 任何操作在执行时都会默认调用这个方法
 默认在子线程执行
 当队列调度操作执行时，才会进入main方法
 */
- (void)main{
    // 默认在子线程执行
    // NSLog(@"%@",[NSThread currentThread]);
    
    NSAssert(self.urlString != nil, @"请传入图片地址");
    NSAssert(self.finishBlock != nil, @"请传入下载完成回调Block");
    
    // 越晚执行越好，一般写在耗时操作后面(可以每行代码后面写一句)
    if(self.isCancelled){
        return;
    }
    
    double sinceTime = [[NSDate date] timeIntervalSince1970];
    // 下载图片
    NSURL *imgURL = [NSURL URLWithString:self.urlString];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    UIImage *img = [UIImage imageWithData:imgData];
    
    double nowTime = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"%f",nowTime - sinceTime);
    
    // 越晚执行越好，一般写在耗时操作后面(可以每行代码后面写一句)
    if(self.isCancelled){
        return;
    }
    
    // 传递至VC
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.finishBlock(img);
    }];
}

+ (instancetype)downloadImageWithURLString:(NSString *)urlString andFinishBlock:(void(^)(UIImage*))finishBlock{
    DownloadOperation *op = [[self alloc] init];
    
    op.urlString = urlString;
    op.finishBlock = finishBlock;
    
    return op;
}
@end
