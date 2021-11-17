//
//  UIButton+ClickRange.h
//  MyCustomDemo
//
//  Created by sx on 2019/11/29.
//  Copyright © 2019 sx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ClickRange)

/// 自定义点击扩大范围，均为负数为扩大，例如（-1, -1, -1, -1）
@property (nonatomic, assign) UIEdgeInsets clickEdgeInsets;
/// 自定义点击扩大倍数
@property (nonatomic, assign) CGFloat clickScale;
/// 自定义点击扩大宽度倍数
@property (nonatomic, assign) CGFloat clickWidthScale;
/// 自定义点击扩大高度倍数
@property (nonatomic, assign) CGFloat clickHeightScale;

@end

NS_ASSUME_NONNULL_END
