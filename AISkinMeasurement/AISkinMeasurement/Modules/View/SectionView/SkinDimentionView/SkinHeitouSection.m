//
//  SkinHeitouSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinHeitouSection.h"
#import "SkinDimentionHeaderView.h"
#import "SkinHeitouCell.h"

@implementation SkinHeitouSection

- (Class)registerCellClass{
    return SkinHeitouCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}


@end
