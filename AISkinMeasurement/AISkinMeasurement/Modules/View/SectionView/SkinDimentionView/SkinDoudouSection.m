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

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index{
    SkinDimentionHeaderView *view = [super viewForSupplementaryElementOfKind:elementKind atIndex:index];
    view.switchButtonClickBlock = self.switchButtonClickBlock;
    if ([self.datas containsString:@"1"]) {
        view.switchButton.selectedSegmentIndex = 1;
    }else{
        view.switchButton.selectedSegmentIndex = 0;
    }
    return view;
}

@end
