//
//  UIButton+Convenient.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/1.
//

#import "UIButton+Convenient.h"

@implementation UIButton (Convenient)

- (void)setText:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

- (NSString *)text{
    return self.currentTitle;
}

- (void)setAttrText:(NSAttributedString *)attrText{
    [self setAttributedTitle:attrText forState:UIControlStateNormal];
}

- (NSAttributedString *)attrText{
    return self.currentAttributedTitle;
}

- (void)addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
