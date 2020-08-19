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
    self.textLabel.textColor = [UIColor colorWithHexString:@"#8A98AD"];
    
    self.layer.borderColor = [UIColor colorWithHexString:@"#96A3B6"].CGColor;
    self.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    // #96A3B6   unselect
    // #42D3DB   select
    if (selected) {
        self.layer.borderColor = [UIColor colorWithHexString:@"#00C3CE"].CGColor;
        self.textLabel.textColor = [UIColor colorWithHexString:@"#00C3CE"];
    }else{
        self.layer.borderColor = [UIColor colorWithHexString:@"#C4CBD6"].CGColor;
        self.textLabel.textColor = [UIColor colorWithHexString:@"#8A98AD"];
    }
}

@end
