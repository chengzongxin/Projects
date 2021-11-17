//
//  CustomColor.h
//  Test
//
//  Created by Joe.cheng on 2021/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomColor : UIColor

+ (UIColor *)dynamicColor:(int)count blk:(UIColor * _Nonnull (^)(int))block;

@end

NS_ASSUME_NONNULL_END
