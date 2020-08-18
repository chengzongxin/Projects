//
//  NSArray+FP.m
//  youxueyun
//
//  Created by gxy on 16/12/29.
//  Copyright © 2016年 gxy. All rights reserved.
//

#import "NSArray+FP.h"

@implementation NSArray (FP)

- (NSArray *)mtfy_filterRepeat {
    NSSet *set = [NSSet setWithArray:self];
    NSArray *result = [set allObjects];
    return result;
}

- (void)mtfy_forEach:(void(^)(id, NSUInteger))block {
    if (!block) {
        return;
    }
    for (id element in self) {
        block(element, [self indexOfObject:element]);
    }
}

- (NSArray *)mtfy_map:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self;
    }
    for (id element in self) {
        [newArray addObject:block(element, [self indexOfObject:element])];
    }
    return newArray;
}

- (NSMutableArray *)mtfy_mutableMap:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self.mutableCopy;
    }
    for (id element in self) {
        [newArray addObject:block(element, [self indexOfObject:element])];
    }
    return newArray;
}

- (NSArray *)mtfy_flatMap:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArr = [NSMutableArray array];
    if (!block) {
        return self;
    }
    return [self mtfy_reduceWithInitialResult:newArr nextPartialResult:^id(id result, id element, NSUInteger index) {
        if ([element isKindOfClass:[NSArray class]]) {
            __kindof NSArray *arr = element;
            [result addObjectsFromArray:[arr mtfy_map:^id(id aElement, NSUInteger aIndex) {
                return block(aElement, aIndex);
            }]];
        } else {
            [result addObject:block(element, index)];
        }
        return result;
    }];
}

- (id)mtfy_filterFirst:(BOOL (^)(id, NSUInteger))block {
    if (!block) {
        return nil;
    }
    for (id element in self) {
        if (block(element, [self indexOfObject:element])) {
            return element;
        }
    }
    return nil;
}

- (NSArray *)mtfy_filter:(BOOL (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self;
    }
    for (id element in self) {
        if (block(element, [self indexOfObject:element])) {
            [newArray addObject:element];
        }
    }
    return newArray;
}

- (NSArray *)mtfy_sort:( NSComparisonResult (^)(id, id)) block {
    return [self sortedArrayUsingComparator:block];
}

- (NSArray *)mtfy_sortAscending:(NSNumber *(^)(id)) block {
    return [self mtfy_sort:^NSComparisonResult(id obj1, id obj2) {
        if (![block(obj1) isKindOfClass:[NSNumber class]]) {
            return NSOrderedSame;
        }
        return (NSComparisonResult) ([block(obj1) compare:block(obj2)] == NSOrderedDescending);
    }];
}

- (NSArray *)mtfy_sortDescending:(NSNumber *(^)(id)) block {
    return [self mtfy_sort:^NSComparisonResult(id obj1, id obj2) {
        if (![block(obj1) isKindOfClass:[NSNumber class]]) {
            return NSOrderedSame;
        }
        return (NSComparisonResult) ([block(obj1) compare:block(obj2)] == NSOrderedAscending);
    }];
}


- (id)mtfy_max:(NSNumber *(^)(id, NSUInteger)) block {
    if (!self.count) {
        return nil;
    }
    __block NSNumber *max = block(self.firstObject, 0);
    __block NSUInteger maxIndex = 0;
    [self mtfy_forEach:^(id element, NSUInteger index) {
        NSNumber *number = block(element, index);
        if ([max compare:number] == NSOrderedAscending) {
            maxIndex = index;
            max = number;
        }
    }];
    return self[maxIndex];
}

- (id)mtfy_min:( NSNumber * (^)(id, NSUInteger)) block {
    if (!self.count) {
        return nil;
    }
    __block NSNumber *min = block(self.firstObject, 0);
    __block NSUInteger minIndex = 0;
    [self mtfy_forEach:^(id element, NSUInteger index) {
        NSNumber *number = block(element, index);
        if ([min compare:number] == NSOrderedDescending) {
            minIndex = index;
            min = number;
        }
    }];
    return self[minIndex];
}

- (id)mtfy_reduceWithInitialResult:(id)initialResult nextPartialResult:(id (^)(id, id, NSUInteger))nextPartialResult {
    id result = initialResult;
    for (id element in self) {
        result = nextPartialResult(result, element, [self indexOfObject:element]);
    }
    return result;
}

- (NSArray *)mtfy_dropFirst {
    if (self.count == 0 || self.count == 1) {
        return @[];
    }
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
}

- (NSArray *)mtfy_removeObjectOfClass:(Class)className {
    if (self.count == 0) {
        return @[];
    }
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self mtfy_forEach:^(id element, NSUInteger index) {
        if ([element isKindOfClass:className]) {
            [indexSet addIndex:index];
        }
    }];
    NSMutableArray *array = [self mutableCopy];
    [array removeObjectsAtIndexes:indexSet];
    return array;
}

#pragma mark - 替换
- (NSArray *)mtfy_replaceAtIndex:(NSInteger)index block:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
    if (!block) {
        return self;
    }
    if (index < 0 || index > newArray.count - 1) {
        return self;
    }
    newArray[index] = block(newArray[index], index);
    return newArray;
}

@end
