//
//  SkinHeiyanquanSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinHeiyanquanSection.h"
#import "SkinHeiyanquanCell.h"
#import "SkinDimentionHeaderView.h"

@implementation SkinHeiyanquanSection

- (Class)registerCellClass{
    return SkinHeiyanquanCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}

@end
