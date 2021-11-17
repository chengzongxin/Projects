//
//  BeCollectThumbupView.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import "BeCollectThumbupView.h"

@implementation BeCollectThumbupView


- (IBAction)clickKnow:(id)sender {
    [TMContentAlert hiddenContentView:self didHiddenBlock:nil];
    if (self.clickBlock) {
        self.clickBlock(sender);
    }
}


@end
