//
//  DrawView.h
//  画板
//
//  Created by Joe on 2019/7/8.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawView : UIView

- (void)setLineWidth:(CGFloat)lineWidth;

- (void)setLineColor:(UIColor *)lineColor;

- (void)clear;

- (void)undo;

- (void)erase;

@end

NS_ASSUME_NONNULL_END
