//
//  HomePageControl.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "HomePageControl.h"

@interface HomePageControl ()

@property (nonatomic,copy) NSArray <UIView *>*pages;

@end

@implementation HomePageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageIndicatorTintColor = [UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1.0];
        self.pageIndicatorNormalColor = [UIColor colorWithRed:184/255.0 green:194/255.0 blue:202/255.0 alpha:1.0];
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    NSMutableArray *pages = [NSMutableArray array];
    CGFloat pageW = 16;
    CGFloat pageH = 3;
    CGFloat space = 6;
    for (int i = 0; i < numberOfPages; i++) {
        CGFloat x = self.center.x - ((numberOfPages/2 - i)*(pageW + space) + pageW/2);
        UIView *page = [[UIView alloc] initWithFrame:CGRectMake(x, 9, pageW, pageH)];
        page.backgroundColor = i ? self.pageIndicatorNormalColor : self.pageIndicatorTintColor;
        [self addSubview:page];
        [pages addObject:page];
    }
    _pages = [pages copy];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    
    for (UIView *page in _pages) {
        page.backgroundColor = self.pageIndicatorNormalColor;
    }
    
    _pages[currentPage].backgroundColor = self.pageIndicatorTintColor;
}

@end
