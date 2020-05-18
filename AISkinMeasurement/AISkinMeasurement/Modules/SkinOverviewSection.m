//
//  SkinOverviewSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinOverviewSection.h"
#import "SkinOverviewCell.h"

@implementation SkinOverviewSection

- (Class)registerCellClass{
    return SkinOverviewCell.class;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.viewController.view.bounds.size.width, 100);
}

@end
