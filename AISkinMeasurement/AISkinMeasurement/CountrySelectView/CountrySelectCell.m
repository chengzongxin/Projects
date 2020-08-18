//
//  CountrySelectCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountrySelectCell.h"
#import "UIColor+Utils.h"

@implementation CountrySelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 2;
    
    self.layer.borderColor = [UIColor colorWithHexString:@"#96A3B6"].CGColor;
    self.layer.borderWidth = 1;
    
//    self.textLabel.opaque = YES;
    // #96A3B6   unselect
    // #42D3DB   select
}

@end
