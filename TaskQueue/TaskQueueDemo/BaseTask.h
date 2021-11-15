//
//  BaseTask.h
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/19.
//


#import <UIKit/UIKit.h>

#import "TaskOperation.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^netBlock)(void);
//typedef void(^taskBlock)(void);

@interface BaseTask : NSObject

- (void)requestDelay:(int)delay block:(netBlock)block;

- (void)request:(netBlock)block;

- (void)showInVC:(UIViewController *)vc delay:(int)delay block:(void (^)(NSInteger))block;


@end

NS_ASSUME_NONNULL_END
