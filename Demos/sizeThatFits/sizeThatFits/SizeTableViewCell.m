//
//  SizeTableViewCell.m
//  sizeThatFits
//
//  Created by Joe.cheng on 2021/3/22.
//

#import "SizeTableViewCell.h"

@implementation SizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGSize)sizeThatFits:(CGSize)size{
    NSLog(@"size that fits :%@",NSStringFromCGSize(size));
//    return [super sizeThatFits:size];
    return CGSizeMake(0, 88);
}

@end
