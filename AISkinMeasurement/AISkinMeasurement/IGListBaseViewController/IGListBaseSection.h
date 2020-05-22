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
// 交给子类实现,需要Cell,注册CellClass,需要header,注册HeaderClass
// 高度默认取Xib的高度
- (Class)registerCellClass;
- (Class)registerReusableViewClass;

@end

NS_ASSUME_NONNULL_END
