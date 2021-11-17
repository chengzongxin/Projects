//
//  NSDictionary+NilSafe.h
//  HouseKeeper
//
//  Created by kevin.huang on 2018/3/13.
//  Copyright © 2018年 binxun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 字典传值非空处理
 */
@interface NSDictionary (NilSafe)

/** 安全返回id */
- (id)safeObjectForKey:(id)key;

/** 安全返回NSString */
- (NSString *)safeStringForKey:(id)key;

/** 安全返回NSArray */
- (NSArray *)safeArrayForKey:(id)key;

/** 安全返回NSDictionary */
- (NSDictionary *)safeDictionaryForKey:(id)key;

@end
