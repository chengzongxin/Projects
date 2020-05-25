//
//  SkinMesureRecordCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMesureRecordCell.h"
#import "UIKitConvenient.h"

@implementation SkinMesureRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 8;
    
    _scoreTagButtonLeft = [[UIButton alloc] initWithFrame:CGRectMake(62,18,97,18)];
    _scoreTagButtonLeft.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    _scoreTagButtonLeft.layer.cornerRadius = 4;
    _scoreTagButtonLeft.layer.borderWidth = 0.5;
    _scoreTagButtonLeft.layer.masksToBounds = YES;
    _scoreTagButtonLeft.layer.borderColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0].CGColor;
    [_scoreTagButtonLeft setTitleColor:rgba(0, 195, 206, 1) forState:UIControlStateNormal];
    [_scoreTagButtonLeft setTitle:@"肌肤良好指数" forState:UIControlStateNormal];
    _scoreTagButtonLeft.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10];
    _scoreTagButtonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _scoreTagButtonLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:_scoreTagButtonLeft];
    
    _scoreTagButtonRight = [[UIButton alloc] initWithFrame:CGRectMake(_scoreTagButtonLeft.bounds.size.width - 29,0,29,18)];
    _scoreTagButtonRight.backgroundColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
//    _scoreTagButtonRight.layer.cornerRadius = 4;
    [_scoreTagButtonRight setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_scoreTagButtonRight setTitle:@"良好" forState:UIControlStateNormal];
    _scoreTagButtonRight.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 10];
    [_scoreTagButtonLeft addSubview:_scoreTagButtonRight];
    
    _checkButton.layer.cornerRadius = 10;
    _checkButton.layer.borderColor = HEXCOLOR(0x00C3CE).CGColor;
    _checkButton.layer.borderWidth = 0.5;
    
    _deleteButton.layer.cornerRadius = 10;
    _deleteButton.layer.borderColor = HEXCOLOR(0xCDCFDE).CGColor;
    _deleteButton.layer.borderWidth = 0.5;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 12;
    frame.size.height -= 12;
    frame.size.width -= 20;
    [super setFrame:frame];
}


@end
