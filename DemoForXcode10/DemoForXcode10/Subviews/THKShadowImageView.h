//
//  THKShadowImageView.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THKShadowImageView : UIView

@property (nonatomic, strong, readonly) UIImageView *contentImageView;

- (void)setLayerShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius;

- (void)setLayerShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius spread:(CGFloat)spread;

@end

NS_ASSUME_NONNULL_END
