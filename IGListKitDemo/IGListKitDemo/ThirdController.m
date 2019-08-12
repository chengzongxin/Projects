//
//  ThirdController.m
//  IGListKitDemo
//
//  Created by Joe on 2019/8/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ThirdController.h"
#import "ThirdCell.h"
#import "ViewController.h"

@interface ThirdController ()

@property (strong, nonatomic) id data;

@end

@implementation ThirdController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 400);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    ThirdCell *cell = [self.collectionContext dequeueReusableCellOfClass:[ThirdCell class] withReuseIdentifier:NSStringFromClass(self.class) forSectionController:self atIndex:index];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.data];
    return cell;
}

- (void)didUpdateToObject:(id)object{
    NSLog(@"%@",object);
    self.data = object;
}

@end
