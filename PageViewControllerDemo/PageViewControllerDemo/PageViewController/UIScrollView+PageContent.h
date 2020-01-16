//
//  UIScrollView+PageContent.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/16.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PageContent)

- (void)didScroll;


- (void)bindNotificationWithSuperview:(UIView *)newSuperview;

/**
 遍历superview 获取PageScrollView
 */
- (PageScrollView *)getPageScrollView;

@end

NS_ASSUME_NONNULL_END
