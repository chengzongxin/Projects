//
//  CountrySelectShowViewCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountrySelectShowViewCell.h"

@implementation CountrySelectShowViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 2;
    self.layer.borderColor = self.titleLabel.textColor.CGColor;
    self.layer.borderWidth = 1;
}

@end
