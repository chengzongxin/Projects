//
//  NSDate+Convenient.h
//  MU
//
//  Created by Joe on 2020/2/26.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Convenient)
//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;
//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;
//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
