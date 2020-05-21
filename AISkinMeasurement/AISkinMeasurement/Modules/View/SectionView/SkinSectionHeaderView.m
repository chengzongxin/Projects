//
//  SkinSectionHeaderView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinSectionHeaderView.h"
#import "UIKitConvenient.h"

@implementation SkinSectionHeaderView


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    

    CGFloat x = 16;
    CGFloat y = 27;
    CGFloat w = 10;
    CGFloat h = 16;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置画笔属性
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetFillColorWithColor(ctx, rgba(0, 195, 206, 1).CGColor);
    // 画平行四边形
    CGContextMoveToPoint(ctx, x + w/2, y);
    CGContextAddLineToPoint(ctx, x, y + h);
    CGContextAddLineToPoint(ctx, x + w/2, y + h);
    CGContextAddLineToPoint(ctx, x + w, y);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
}


- (void)setModel:(id)model{
    [super setModel:model];
    
    NSLog(@"%@",model);
}

@end
