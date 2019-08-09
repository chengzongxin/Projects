//
//  SecondController.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "SecondController.h"
#import "SecondCell.h"

@interface SecondController ()

@property (strong, nonatomic) id data;

@end

@implementation SecondController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 200);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    SecondCell *cell = [self.collectionContext dequeueReusableCellOfClass:[SecondCell class] withReuseIdentifier:NSStringFromClass(self.class) forSectionController:self atIndex:index];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.data];
    return cell;
}

- (void)didUpdateToObject:(id)object{
    NSLog(@"%@",object);
    self.data = object;
}

@end
