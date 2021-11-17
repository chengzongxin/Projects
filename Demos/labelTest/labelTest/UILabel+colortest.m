//
//  UILabel+colortest.m
//  labelTest
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "UILabel+colortest.h"

@implementation UILabel (colortest)

- (lableColorblock)textcolor1{
    return ^(id value){
        self.textColor = value;
        NSLog(@"textcolor1 %@",value);
        return self;
    };
}

@end
