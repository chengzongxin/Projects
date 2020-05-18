//
//  SkinOverviewCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinOverviewCell.h"

@implementation SkinOverviewCell

- (void)setModel:(id)model{
    [super setModel:model];
    
    _text.text = model;
    NSLog(@"%@",model);
}

@end
