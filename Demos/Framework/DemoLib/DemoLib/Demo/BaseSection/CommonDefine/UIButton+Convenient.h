//
//  UIButton+Convenient.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Convenient)

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSAttributedString *attrText;

- (void)addTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
