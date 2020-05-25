//
//  NormalAlert.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "NormalAlert.h"

@implementation NormalAlert

- (IBAction)cancel:(id)sender {
    if (self.tapItem) {
        self.tapItem(0);
    }
}

- (IBAction)delete:(id)sender {
    if (self.tapItem) {
        self.tapItem(1);
    }
}

@end
