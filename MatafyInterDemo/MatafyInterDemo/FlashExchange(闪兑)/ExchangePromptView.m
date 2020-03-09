//
//  ExchangePromptView.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ExchangePromptView.h"

@implementation ExchangePromptView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}

+ (instancetype)xibView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)dismiss{
    [self removeFromSuperview];
}

+ (void)show{
    ExchangePromptView *view = [self xibView];
    view.frame = UIScreen.mainScreen.bounds;
    
    [UIApplication.sharedApplication.keyWindow addSubview:view];
}



@end
