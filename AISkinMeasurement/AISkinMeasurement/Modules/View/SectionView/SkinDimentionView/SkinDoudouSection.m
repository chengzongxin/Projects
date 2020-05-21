//
//  SkinDoudouSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinDoudouSection.h"
#import "SkinDimentionHeaderView.h"
#import "SkinDoudouCell.h"

@implementation SkinDoudouSection

- (Class)registerCellClass{
    return SkinDoudouCell.class;
}

- (Class)registerReusableViewClass{
    return SkinDimentionHeaderView.class;
}

@end
