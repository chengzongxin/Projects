//
//  Task1.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "Task1.h"

@interface Task1 ()

@property (nonatomic, weak) UIView *view;

@end

@implementation Task1

- (instancetype)initWithView:(UIView *)view{
    self = [super init];
    if (!self) { return nil;}
    
    self.view = view;
    
    return self;
}


- (void)execute{
    [UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        
    }completion:^(BOOL finished) {
        [self finish];
    }];
}



@end
