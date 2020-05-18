//
//  SkinEightDimentionSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinEightDimentionSection.h"
#import "SkinEightDimentionCell.h"
#import "SkinSectionHeaderView.h"
@implementation SkinEightDimentionSection

- (Class)registerCellClass{
    return SkinEightDimentionCell.class;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.viewController.view.bounds.size.width, 500);
}

- (Class)registerReusableViewClass{
    return SkinSectionHeaderView.class;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    return CGSizeMake(self.viewController.view.bounds.size.width, 100);
}

@end
