//
//  FirstController.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "FirstController.h"
#import "FirstCell.h"
@interface FirstController ()

@property (strong, nonatomic) id data;

@end

@implementation FirstController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 300);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    FirstCell *cell = [self.collectionContext dequeueReusableCellOfClass:[FirstCell class] withReuseIdentifier:NSStringFromClass(self.class) forSectionController:self atIndex:index];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.data];
    return cell;
}

- (void)didUpdateToObject:(id)object{
    NSLog(@"%@",object);
    self.data = object;
}



@end
