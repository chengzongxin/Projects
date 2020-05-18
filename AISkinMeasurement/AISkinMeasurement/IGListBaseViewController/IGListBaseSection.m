//
//  IGListBaseSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "IGListBaseSection.h"
#import "IGListBaseCell.h"

@interface IGListBaseSection ()

@property (strong, nonatomic) Class cellClass;

@end

@implementation IGListBaseSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.supplementaryViewSource = self;
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        [self prepare];
        self.cellClass = [self registerCellClass];
    }
    return self;
}

#pragma mark - Public Method
- (void)prepare{}
- (Class)registerCellClass{return IGListBaseCell.class;}

#pragma mark - IGList Datasouce
- (NSInteger)numberOfItems{
    return !!self.datas;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeZero;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    IGListBaseCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass(self.cellClass.class) bundle:nil forSectionController:self atIndex:index];
    cell.model = self.datas;
    return cell;
}

- (void)didUpdateToObject:(id)object{
    self.datas = object;
}

#pragma mark - IGListSupplementaryViewSource
- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    UICollectionReusableView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self class:[UICollectionReusableView class] atIndex:index];
    return header;
}
@end
