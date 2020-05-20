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
    // 通过xib获取
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self registerCellClass]) owner:nil options:nil] firstObject];
    return CGSizeMake(self.viewController.view.bounds.size.width, view.bounds.size.height);
}

@end
