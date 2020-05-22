//
//  SkinBandianCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinBandianCell.h"

@implementation SkinBandianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSwith:_quebanSwitch];
    [self setupSwith:_huanghebanSwith];
    [self setupSwith:_zhiSwitch];
    [self setupSwith:_otherSwith];
}

- (void)setupSwith:(SPMultipleSwitch *)switchButton{
    [switchButton initialWithItems:@[@"无",@"轻度",@"中度",@"严重"]];
    switchButton.titleFont = [UIFont boldSystemFontOfSize:12];
    switchButton.frame = CGRectMake(15, 180, 192, 24);
    switchButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    switchButton.selectedTitleColor = UIColor.whiteColor;
    switchButton.titleColor = [UIColor colorWithRed:121/255.0 green:132/255.0 blue:156/255.0 alpha:1.0];
    switchButton.contentInset = 0;
    switchButton.spacing = 10;
    switchButton.trackerColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
    switchButton.userInteractionEnabled = NO;
//    [switchButton addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(NSString *)model{
    [super setModel:model];
    
    _quebanSwitch.selectedSegmentIndex = 0;
    _huanghebanSwith.selectedSegmentIndex = 1;
    _zhiSwitch.selectedSegmentIndex = 2;
    _otherSwith.selectedSegmentIndex = 3;
    
    if ([model containsString:@"1"]) {
        _imgV.image = [UIImage imageNamed:@"animation_man"];
    }else{
        _imgV.image = [UIImage imageNamed:@"qian"];
    }
}



@end
