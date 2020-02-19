
//
//  IndexListCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "IndexListCell.h"

@implementation IndexListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _increaseLabel.layer.cornerRadius = 2;
    _increaseLabel.layer.masksToBounds = YES;
}

- (void)setModel:(ExponentModelData *)model{
    _model = model;
    
    _indexLabel.text = [NSString stringWithFormat:@"%@ %@",model.symbolCode,model.symbolName];
    
    _priceLabel.text = model.cnyPrice;
    
    _increaseLabel.text = [NSString stringWithFormat:@"%0.2f%%",model.increase/100.0];
    CGFloat width = [_increaseLabel.text sizeWithAttributes:@{NSFontAttributeName:_increaseLabel.font}].width + 8;
    [self replace:_increaseLabel widthCons:width];
}

// 替换约束
- (void)replace:(UIView *)view widthCons:(CGFloat)width{
    NSMutableArray *deleteCons = [NSMutableArray array];
    for (NSLayoutConstraint *cons in view.constraints) {
        if (cons.firstAttribute == NSLayoutAttributeWidth && cons.secondAttribute == NSLayoutAttributeNotAnAttribute) {
            [deleteCons addObject:cons];
        }
    }
    [view removeConstraints:deleteCons];
    
    NSLayoutConstraint *widthCos = [NSLayoutConstraint constraintWithItem:_increaseLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:width];
    [_increaseLabel addConstraint:widthCos];
    
}

@end
