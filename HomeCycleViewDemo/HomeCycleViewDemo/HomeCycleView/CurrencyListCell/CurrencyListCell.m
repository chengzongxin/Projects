//
//  CurrencyListCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "CurrencyListCell.h"

@implementation CurrencyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HotSymbolModelData *)model{
    _model = model;
    
    _symbolLabel.text = [NSString stringWithFormat:@"%@ %@",model.symbolName,model.symbol];
    
    CGFloat width = [_symbolLabel.text sizeWithAttributes:@{NSFontAttributeName:_symbolLabel.font}].width + 16;
    _symbolWidth.constant = width;
    
    _priceLabel.text = model.price;
    
    _increaseLabel.text = [NSString stringWithFormat:@"%0.2f%%",model.increase/100.0];
    
    _infoLabel.text = model.info;
}

@end
