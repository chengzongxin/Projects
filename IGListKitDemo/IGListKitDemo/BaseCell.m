//
//  BaseCell.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 40)];
        _titleLabel.textColor = UIColor.redColor;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


@end
