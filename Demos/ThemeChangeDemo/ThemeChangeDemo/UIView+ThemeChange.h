//
//  UIView+ThemeChange.h
//  Test
//
//  Created by Joe.cheng on 2021/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ThemeChange)

- (void)_qmui_themeDidChangeByManager:(BOOL)shouldEnumeratorSubviews;


@end

NS_ASSUME_NONNULL_END
