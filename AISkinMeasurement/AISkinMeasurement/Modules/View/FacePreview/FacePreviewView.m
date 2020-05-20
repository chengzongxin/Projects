//
//  PreviewView.m
//  CameraDemo
//
//  Created by Joe on 2020/4/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "FacePreviewView.h"

@interface FacePreviewView ()

@property (strong, nonatomic) UIImageView *faceImageView;

@property (strong, nonatomic) UILabel *countingLabel;

@end

@implementation FacePreviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.faceImageView];
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

- (UILabel *)countingLabel{
    if (!_countingLabel) {
        _countingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _countingLabel.center = self.center;
        _countingLabel.font = [UIFont boldSystemFontOfSize:80];
        _countingLabel.textColor = UIColor.whiteColor;
    }
    return _countingLabel;
}

- (void)setFacePosition:(CGRect)facePosition{
    _facePosition = facePosition;
//    NSLog(@"%@,%@",NSStringFromCGRect(facePosition),NSStringFromCGRect(self.faceImageView.frame));
    CGFloat scale = UIScreen.mainScreen.scale;
    _faceImageView.frame = CGRectMake(facePosition.origin.y/scale, facePosition.origin.x/scale, facePosition.size.width, facePosition.size.height);
//    _faceImageView.center = facePosition.origin;
}

@end
