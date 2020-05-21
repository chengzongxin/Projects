//
//  SkinBandianSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinBandianSection.h"
#import "SkinDimentionHeaderView.h"
#import "SkinBandianCell.h"

@implementation SkinBandianSection

- (Class)registerCellClass{
    return SkinBandianCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}

@end
