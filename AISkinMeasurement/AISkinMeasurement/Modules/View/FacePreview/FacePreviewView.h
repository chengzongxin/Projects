//
//  PreviewView.h
//  CameraDemo
//
//  Created by Joe on 2020/4/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface FacePreviewView : UIView

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (assign, nonatomic) CGRect facePosition;

@property (nonatomic,copy) void (^countDown)(void);

@end

NS_ASSUME_NONNULL_END
