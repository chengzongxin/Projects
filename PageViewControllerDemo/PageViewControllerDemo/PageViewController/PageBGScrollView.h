//
//  PageScrollView.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/8.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageBGScrollView : UIScrollView <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *headerView;

@property (assign, nonatomic) BOOL fixed;

@property (assign, nonatomic) BOOL neverFixed;

@end

NS_ASSUME_NONNULL_END
