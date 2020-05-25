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

- (instancetype)initWithXib:(Class)className;

@property (strong, nonatomic) UIView *customView;
- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
