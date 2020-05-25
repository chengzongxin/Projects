//
//  SkinMeasureAlert.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinMeasureAlert.h"

@implementation SkinMeasureAlert

- (IBAction)measureSelf:(id)sender {
    [self dismiss];
    if (self.tapItem) {
        self.tapItem(0);
    }
}
- (IBAction)measureFriend:(id)sender {
    [self dismiss];
    if (self.tapItem) {
        self.tapItem(1);
    }
}
- (IBAction)checkMeasureList:(id)sender {
    [self dismiss];
    if (self.tapItem) {
        self.tapItem(2);
    }
}
- (IBAction)close:(id)sender {
    [self dismiss];
}

- (void)setTapItem:(void (^)(int))tapItem{
    _tapItem = tapItem;
    if ([self.subviews.firstObject isKindOfClass:self.class]) {
         SkinMeasureAlert *superView = (SkinMeasureAlert *)self.subviews.firstObject;
        superView.tapItem = tapItem;
    }
}


@end
