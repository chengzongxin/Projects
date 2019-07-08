//
//  DownloadOperation.h
//  NSOperationDemo
//
//  Created by Joe on 2019/7/9.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadOperation : NSOperation
/**
 类方法实例化自定义操作

 @param urlString 图片地址
 @param finishBlock 完成回调
 @return 自定义操作
 */
+ (instancetype)downloadImageWithURLString:(NSString *)urlString andFinishBlock:(void(^)(UIImage*))finishBlock;
@end

NS_ASSUME_NONNULL_END
