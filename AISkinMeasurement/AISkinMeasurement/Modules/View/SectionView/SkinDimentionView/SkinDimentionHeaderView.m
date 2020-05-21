//
//  SkinDimentionHeaderView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinDimentionHeaderView.h"
#import "UIKitConvenient.h"

@implementation SkinDimentionHeaderView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_switchButton initialWithItems:@[@"本人",@"动画"]];
    _switchButton.titleFont = [UIFont boldSystemFontOfSize:12];
    _switchButton.frame = CGRectMake(15, 180, 192, 24);
    _switchButton.backgroundColor = UIColor.whiteColor;
    _switchButton.selectedTitleColor = UIColor.whiteColor;
    _switchButton.titleColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
    _switchButton.contentInset = 0;
    _switchButton.spacing = 10;
    _switchButton.trackerColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
    [_switchButton addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
    
    _switchButton.layer.borderColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0].CGColor;
    _switchButton.layer.borderWidth = 0.5;
}

- (void)switchAction3:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
}


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
