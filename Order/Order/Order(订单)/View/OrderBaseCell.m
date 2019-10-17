//
//  OrderBaseCell.m
//  Order
//
//  Created by Joe on 2019/10/17.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "OrderBaseCell.h"

@implementation OrderBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColor.clearColor;
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    
    self.logoImageView.layer.cornerRadius = 12;
    self.logoImageView.layer.masksToBounds = YES;
    
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.firstButton.layer.cornerRadius = 15;
    self.firstButton.layer.masksToBounds = YES;
    self.firstButton.layer.borderColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1].CGColor;
    self.firstButton.layer.borderWidth = 1;
    
    self.secondButton.layer.cornerRadius = 15;
    self.secondButton.layer.masksToBounds = YES;
    self.secondButton.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1].CGColor;
    self.secondButton.layer.borderWidth = 1;
}

@end
