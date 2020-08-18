//
//  CountrySelectButtonView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CountrySelectButtonView.h"
#import "UIColor+Utils.h"

@implementation CountrySelectButtonView
+ (instancetype)xibView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor colorWithHexString:@"#F1F3F6"].CGColor;
    self.layer.borderWidth = 0.5;
    
    _resetButton.layer.borderColor = _resetButton.currentTitleColor.CGColor;
    _resetButton.layer.borderWidth = 1;
}
- (IBAction)resetClick:(id)sender {
    if (self.tapItem) {
        self.tapItem(1);
    }
}
- (IBAction)confirmClick:(id)sender {
    if (self.tapItem) {
        self.tapItem(2);
    }
}

@end
