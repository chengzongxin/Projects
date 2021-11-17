//
//  Define_SetValues.h
//  TBasicLib
//
//  Created by kevin.huang on 14-6-30.
//  Copyright (c) 2014年 binxun. All rights reserved.
//  给model的属性赋值

#ifndef TBasicLib_Define_SetValues_h
#define TBasicLib_Define_SetValues_h

/*
 根据dict和keypath给model里的property赋NSString类型的值
 参数：
 dict    字典,将取出数据的NSDictionary
 keypath  键名，将获取的数据的键名
 property  model里的属性，给该属性赋值
 */
#define kSetStrForProperty(dict,keypath,property) do \
{ \
if(ValidateDicWithKey(dict,keypath)){\
NSString *src = [dict valueForKeyPath:keypath]; \
if([src isKindOfClass:NSString.class]) { \
self.property = (src)?src:nil; \
} \
}\
} while (0);


/*
 根据dict和keypath给model里的property赋整数类型的值
 参数：
 dict    字典,将取出数据的NSDictionary
 keypath  键名，将获取的数据的键名
 property  model里的属性，给该属性赋值
 */
#define kSetInterForProperty(dict,keypath,property) do \
{ \
if(ValidateDicWithKey(dict,keypath)){\
NSInteger inter = [[dict objectForKey:keypath] integerValue]; \
self.property = inter;\
}\
} while (0);

/*
 根据dict和keypath给model里的property赋CGFloat类型的值
 参数：
 dict    字典,将取出数据的NSDictionary
 keypath  键名，将获取的数据的键名
 property  model里的属性，给该属性赋值
 */
#define kSetFloatForProperty(dict,keypath,property) do \
{ \
if(!ValidateDicWithKey(dict,keypath)){\
CGFloat f = [[dict objectForKey:keypath] floatValue]; \
self.property = f;\
}\
} while (0);


/*
 给dict添加键名keypath 值property property为nsstring类型，非nsstring类型则值为@“”
 参数：
 dict    字典,将添加键值对的NSDictionary
 keypath  键名，将添加的键名
 property  键值,nsstring 类型
 */
#define kSetStrForDict(dict, key, str) do \
{ \
NSString* temp = str;\
if([temp isKindOfClass:NSString.class])\
{\
[dict setObject:str forKey:key];\
}\
else\
{\
[dict setObject:@"" forKey:key];\
}\
} while (0);


#endif
