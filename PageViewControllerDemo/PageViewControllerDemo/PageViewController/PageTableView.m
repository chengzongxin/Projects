//
//  PageTableView.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/8.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageTableView.h"
#import "PageBGScrollView.h"
#import "UIView+Frame.h"
#import "PageConst.h"
#import "UIScrollView+PageContentScrollView.h"

@implementation PageTableView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    [self bindNotificationWithSuperview:newSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self didScroll];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:PageBGScrollView.class]) {
        return YES;
    }
    return NO;
}

@end
