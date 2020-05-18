//
//  IGListBaseSection.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol IGListBaseSectionDelegate <NSObject>
//
//- (Class)registerCellClass;
//
//@end

@interface IGListBaseSection : IGListSectionController<IGListSupplementaryViewSource>

@property (copy, nonatomic) id datas;

- (Class)registerCellClass;
- (void)prepare;

@end

NS_ASSUME_NONNULL_END
