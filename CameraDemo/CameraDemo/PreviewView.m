//
//  PreviewView.m
//  CameraDemo
//
//  Created by Joe on 2020/4/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PreviewView.h"

@implementation PreviewView

+ (Class)layerClass{
    return AVCaptureVideoPreviewLayer.class;
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer{
    return (AVCaptureVideoPreviewLayer *)self.layer;
}

@end
