//
//  IGListBaseSection.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "IGListBaseSection.h"
#import "IGListBaseReusableView.h"
#import "IGListBaseCell.h"

@interface IGListBaseSection ()

@end

@implementation IGListBaseSection

- (instancetype)init {
    self = [super init];
    if (self) {
        self.supplementaryViewSource = self;
        self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
    }
    return self;
}

#pragma mark - Public Method
- (Class)registerCellClass{return IGListBaseCell.class;}
- (Class)registerReusableViewClass{return IGListBaseReusableView.class;}

#pragma mark - IGList Datasouce
- (NSInteger)numberOfItems{
    return !!self.datas;
}

// 通过xib获取cell尺寸
- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self registerCellClass]) owner:nil options:nil] firstObject];
    return CGSizeMake(self.viewController.view.bounds.size.width, view.bounds.size.height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    IGListBaseCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([self registerCellClass].class) bundle:nil forSectionController:self atIndex:index];
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
    if ([NSStringFromClass([self registerReusableViewClass]) isEqualToString:NSStringFromClass(IGListBaseReusableView.class)]) {
        // 没有实现header协议方法
        return CGSizeZero;
    }
    
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self registerReusableViewClass]) owner:nil options:nil] firstObject];
    return CGSizeMake(self.viewController.view.bounds.size.width, view.bounds.size.height);
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    IGListBaseReusableView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:NSStringFromClass(self.registerReusableViewClass) bundle:nil atIndex:index];
    if ([header respondsToSelector:@selector(setModel:)]) {
        header.model = self.datas;
    }
    return header;
}
@end
