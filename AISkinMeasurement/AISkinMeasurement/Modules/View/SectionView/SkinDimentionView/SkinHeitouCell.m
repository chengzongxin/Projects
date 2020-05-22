//
//  SkinHeitouCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinHeitouCell.h"

@implementation SkinHeitouCell

- (void)setModel:(NSString *)model{
    [super setModel:model];
    
    if ([model containsString:@"1"]) {
        _imgV.image = [UIImage imageNamed:@"qian"];
    }else{
        _imgV.image = [UIImage imageNamed:@"animation_man"];
    }
}



@end
