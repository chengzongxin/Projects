//
//  NSArray+FP.h
//  youxueyun
//
//  Created by gxy on 16/12/29.
//  Copyright © 2016年 gxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (FP)

#pragma mark - 遍历
/**
 * 数组遍历
 */
- (void)mtfy_forEach: (void (NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组遍历, 返回不可变数据
 */
- (NSArray *)mtfy_map: (id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组遍历, 返回可变数据
 */
- (NSMutableArray *)mtfy_mutableMap:(id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组展开 element的类型是数组元素的元素类型
 */
- (NSArray *)mtfy_flatMap:(id(NS_NOESCAPE ^)(id element, NSUInteger index))block;

#pragma mark - 筛选
/**
 * 数据筛选
 */
- (NSArray<ObjectType> *)mtfy_filter:(BOOL(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 获取第一个符合的元素
 */
- (ObjectType)mtfy_filterFirst:(BOOL(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

#pragma mark - 去重
/**
 * 去除重复元素
 */
- (NSArray<ObjectType> *)mtfy_filterRepeat;

#pragma mark - 排序
/**
 * 数组排序
 */
- (NSArray<ObjectType> *)mtfy_sort:( NSComparisonResult (^)(ObjectType obj1, ObjectType obj2)) block;

/**
 * 数组排序(降序)
 */
- (NSArray<ObjectType> *)mtfy_sortAscending:( NSNumber *(^)(ObjectType element)) block;

/**
 * 数组排序(升序)
 */
- (NSArray<ObjectType> *)mtfy_sortDescending:( NSNumber *(^)(ObjectType element)) block;

/**
 * 获取最大值
 */
- (ObjectType)mtfy_max:(NSNumber * (^)(ObjectType element)) block;

/**
 * 获取最小值
 */
- (ObjectType)mtfy_min:(NSNumber * (^)(ObjectType element)) block;

/**
 * 累加函数
 */
- (ObjectType)mtfy_reduceWithInitialResult:(id)initialResult nextPartialResult:(id (^)(id result, ObjectType element, NSUInteger index))nextPartialResult;

#pragma mark - 移除
/**
 * 移除第一个
 */
- (NSArray<ObjectType> *)mtfy_dropFirst;
/**
 * 移除某种类型的元素
 */
- (NSArray<ObjectType> *)mtfy_removeObjectOfClass:(Class)className;

#pragma mark - 替换
- (NSArray<ObjectType> *)mtfy_replaceAtIndex:(NSInteger)index block: (id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

@end
