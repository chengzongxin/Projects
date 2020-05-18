//
//  SkinEightDimentionSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinEightDimentionSection.h"
#import "SkinEightDimentionCell.h"
@implementation SkinEightDimentionSection

- (Class)registerCellClass{
    return SkinEightDimentionCell.class;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.viewController.view.bounds.size.width, 500);
}

@end
