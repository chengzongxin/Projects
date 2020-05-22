//
//  PreviewView.m
//  CameraDemo
//
//  Created by Joe on 2020/4/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "FacePreviewView.h"
#import "WZBCountdownLabel.h"

@interface FacePreviewView ()

@property (strong, nonatomic) UIImageView *faceImageView;

@property (strong, nonatomic) UILabel *promptLabel;

@end

@implementation FacePreviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.faceImageView];
        [self addSubview:self.promptLabel];
    }
    return self;
}

+ (Class)layerClass{
    return AVCaptureVideoPreviewLayer.class;
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (UIImageView *)faceImageView{
    if (!_faceImageView) {
        _faceImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"face_position"]];
        _faceImageView.contentMode = UIViewContentModeScaleToFill;
        _faceImageView.center = self.center;
    }
    return _faceImageView;
}

- (UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(26,self.bounds.size.height - 41 - 63,self.bounds.size.width - 26 * 2,63)];
        // shadow
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 4;
        shadow.shadowColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.16];
        shadow.shadowOffset = CGSizeMake(0,2);

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"温馨提示：\n\n为了更准确检测肌肤状态，拍摄前，请摘掉眼镜、卸妆洁面、在正常的光线下拍摄"
                                                                                   attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                                                                                 NSForegroundColorAttributeName: UIColor.whiteColor,
                                                                                                 NSShadowAttributeName: shadow}];
        [string addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]} range:NSMakeRange(0, 4)];

        _promptLabel.attributedText = string;
        _promptLabel.textAlignment = NSTextAlignmentLeft;
        _promptLabel.numberOfLines = 0;
    }
    return _promptLabel;
}

- (void)setFacePosition:(CGRect)facePosition{
    if (CGRectContainsRect(_facePosition, CGRectZero)) {
        [self animateCounting];
    }
    
    _facePosition = facePosition;
    NSLog(@"%@,%@",NSStringFromCGRect(facePosition),NSStringFromCGRect(self.faceImageView.frame));
//    CGFloat scale = UIScreen.mainScreen.scale;
//    _faceImageView.frame = CGRectMake(facePosition.origin.y/scale, facePosition.origin.x/scale, facePosition.size.width, facePosition.size.height);
}

- (void)animateCounting{
    __weak __typeof__(self) weakSelf = self;
    [WZBCountdownLabel playWithNumber:3 endTitle:nil success:^(WZBCountdownLabel *label) {
        NSLog(@"%s",__FUNCTION__);
        if (weakSelf.countDown) {
            weakSelf.countDown();
        }
    }];
}

@end
