//
//  Task4.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "Task4.h"

@implementation Task4

- (void)execute{
    __block UIImage *img1;
    __block UIImage *img2;
    __block UIImage *img3;
    // 并发任务
    // 创建线程组队列
    dispatch_group_t group = dispatch_group_create();
    // 一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue.group", NULL);
    
    // 进入线程队列
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self loadWithUrlStr:@"https://img2.baidu.com/it/u=1077360284,2857506492&fm=26&fmt=auto&gp=0.jpg" completion:^(UIImage *image) {
            // 离开线程队列
            img1 = image;
            dispatch_group_leave(group);
        }];
    });
    
    // 进入线程队列
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self loadWithUrlStr:@"https://img2.baidu.com/it/u=2421505363,3507499484&fm=26&fmt=auto&gp=0.jpg" completion:^(UIImage *image) {
            // 离开线程队列
            img2 = image;
            dispatch_group_leave(group);
        }];
    });
    
    // 进入线程队列
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [self loadWithUrlStr:@"https://img1.baidu.com/it/u=2838780513,3053016818&fm=26&fmt=auto&gp=0.jpg" completion:^(UIImage *image) {
            // 离开线程队列
            img3 = image;
            dispatch_group_leave(group);
        }];
    });
    
    //线程组的监听通知
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程");
                [self finish:@[img1,img2,img3]];
        });
    });

}

- (void)loadWithUrlStr:(NSString *)urlStr completion:(void (^)(UIImage *image))complete{
    NSURL *url = [NSURL URLWithString:urlStr];
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *img = [UIImage imageWithData:data];
        NSLog(@"%@",img);
        complete(img);
    }] resume]; //启动任务
}


/// 在子线程执行
- (BOOL)executeOnMainThread{
    return NO;
}

@end
