//
//  SkinMaokongSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMaokongSection.h"
#import "SkinMaokongCell.h"
#import "SkinDimentionHeaderView.h"

@implementation SkinMaokongSection

- (Class)registerCellClass{
    return SkinMaokongCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}

@end
