//
//  NSArray+IGListKit.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/14.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "NSArray+IGListKit.h"

@implementation NSArray (IGListKit)

- (id<NSObject>)diffIdentifier{
    return self;
}


- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return YES;
}

@end
