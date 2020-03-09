//
//  ExchangeButton.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ExchangeButton.h"

@implementation ExchangeButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"%@-%@",NSStringFromCGPoint(point),event);
    if (point.x > 220 && point.x < 270) {
        return YES;
    }else{
        return NO;
    }
}

@end
