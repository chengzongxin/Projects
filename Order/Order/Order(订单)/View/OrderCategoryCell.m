//
//  OrderCategoryCell.m
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "OrderCategoryCell.h"

@implementation OrderCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.layer.cornerRadius = 15;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
//    NSLog(@"%s--%@",__FUNCTION__,self);
    
    
    if (selected) {
        self.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1];
        self.titleLabel.layer.borderColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1].CGColor;
    }else{
        self.titleLabel.textColor = [UIColor colorWithRed:87/255.0 green:102/255.0 blue:122/255.0 alpha:1.0];
        self.titleLabel.layer.borderColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1].CGColor;
    }
}

@end
