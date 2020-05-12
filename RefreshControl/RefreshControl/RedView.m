//
//  RedView.m
//  RefreshControl
//
//  Created by Joe on 2020/5/12.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"%s",__FUNCTION__);
}



- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    
    NSLog(@"%s,%@",__FUNCTION__,newSuperview);
}

@end
