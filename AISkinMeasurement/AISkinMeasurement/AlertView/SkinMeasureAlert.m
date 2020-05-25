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
    if (self.tapItem) {
        self.tapItem(0);
    }
}
- (IBAction)measureFriend:(id)sender {
    if (self.tapItem) {
        self.tapItem(1);
    }
}
- (IBAction)checkMeasureList:(id)sender {
    if (self.tapItem) {
        self.tapItem(2);
    }
}
- (IBAction)close:(id)sender {
    if (self.tapItem) {
        self.tapItem(3);
    }
}


@end
