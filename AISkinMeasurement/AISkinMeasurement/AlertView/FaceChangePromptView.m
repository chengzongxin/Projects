//
//  FaceChangePromptView.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/6/29.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "FaceChangePromptView.h"
#import "UIView+Convenient.h"

@interface FaceChangePromptView ()

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation FaceChangePromptView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [_label1 halfCircleCornerDirect:UIRectCornerBottomRight radius:8];
    [_label2 halfCircleCornerDirect:UIRectCornerBottomRight radius:8];
    [_label3 halfCircleCornerDirect:UIRectCornerBottomRight radius:8];
}


- (IBAction)confirm:(id)sender {
    if (self.tapItem) {
        self.tapItem(0);
    }
}


@end
