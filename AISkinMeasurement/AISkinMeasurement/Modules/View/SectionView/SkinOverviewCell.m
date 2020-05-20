//
//  SkinOverviewCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinOverviewCell.h"
#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation SkinOverviewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _circleProgress = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 88 - 25, 20, 88, 88) pathBackColor:rgba(234, 235, 246, 1) pathFillColor:rgba(0, 195, 206, 1) startAngle:0 strokeWidth:7];
    _circleProgress.startAngle = 135;
    _circleProgress.reduceAngle = 90;
    [self addSubview:self.circleProgress];
}

- (void)setModel:(id)model{
    [super setModel:model];
    
    NSLog(@"%@",model);
    _circleProgress.progress = [model intValue]/100.0;
}

@end
