//
//  AlertBaseView.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertBaseView : UIView <CAAnimationDelegate>
// 交给子类实现,默认以当前子类的同名xib加载
- (UIView *)prepareSubviews;
// 供子类调用
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
