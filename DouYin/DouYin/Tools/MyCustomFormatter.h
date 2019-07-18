//
//  MyCustomFormatter.h
//  DouYin
//
//  Created by Joe on 2019/7/18.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCustomFormatter : NSObject<DDLogFormatter>
{
    DDAtomicCounter *atomicLoggerCounter;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end

NS_ASSUME_NONNULL_END
