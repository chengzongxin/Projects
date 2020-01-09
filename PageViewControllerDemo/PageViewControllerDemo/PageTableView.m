//
//  PageTableView.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/8.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageTableView.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"

@implementation PageTableView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    PageScrollView *bgScrollView = (PageScrollView *)scrollView.superview.superview.superview;
    if ([bgScrollView isKindOfClass:UIScrollView.class]) {
        
        if (bgScrollView.contentOffset.y < (200 - 88)) {
            scrollView.contentOffset = CGPointZero;
        }
        
        if (scrollView.contentOffset.y <= 0) {
            scrollView.contentOffset = CGPointZero;
            // tag = 1不滑动
            bgScrollView.tag = 1;
            
        }else{
            // tag = 0 默认滑动
            bgScrollView.tag = 0;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    NSLog(@"%s",__FUNCTION__);
//    if (otherGestureRecognizer.view.tag == 888) { // contentScrollView 不滑动
//        return NO;
//    }
    if ([otherGestureRecognizer.view isKindOfClass:PageScrollView.class]) {
        return YES;
    }
    
//    NSLog(@"%@",otherGestureRecognizer.view);
    return NO;
}

@end
