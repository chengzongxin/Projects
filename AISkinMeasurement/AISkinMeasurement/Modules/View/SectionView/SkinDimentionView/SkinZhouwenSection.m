//
//  SkinZhouwenSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinZhouwenSection.h"
#import "SkinZhouwenCell.h"
#import "SkinDimentionHeaderView.h"

@implementation SkinZhouwenSection

- (Class)registerCellClass{
    return SkinZhouwenCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}

@end
