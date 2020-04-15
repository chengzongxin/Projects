//
//  ViewController.m
//  CameraDemo
//
//  Created by Joe on 2020/4/15.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PreviewView.h"

@interface ViewController () <AVCapturePhotoCaptureDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDevice *videoDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (strong, nonatomic) AVCapturePhotoOutput *photoOutput;
@property (weak, nonatomic) IBOutlet PreviewView *previewView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    [self grantAccess];
}

- (IBAction)switchCamere:(id)sender {
    
    
    AVCaptureDevice* currentVideoDevice = self.videoDeviceInput.device;
    AVCaptureDevicePosition currentPosition = currentVideoDevice.position;
    
    AVCaptureDevicePosition preferredPosition;
    AVCaptureDeviceType preferredDeviceType;
    
    switch (currentPosition)
    {
        case AVCaptureDevicePositionUnspecified:
        case AVCaptureDevicePositionFront:
            preferredPosition = AVCaptureDevicePositionBack;
            preferredDeviceType = AVCaptureDeviceTypeBuiltInDualCamera;
            break;
        case AVCaptureDevicePositionBack:
            preferredPosition = AVCaptureDevicePositionFront;
            preferredDeviceType = AVCaptureDeviceTypeBuiltInTrueDepthCamera;
            break;
    }
    
    // Create a device discovery session.
    NSArray<AVCaptureDeviceType>* deviceTypes = @[AVCaptureDeviceTypeBuiltInWideAngleCamera, AVCaptureDeviceTypeBuiltInDualCamera, AVCaptureDeviceTypeBuiltInTrueDepthCamera];
    AVCaptureDeviceDiscoverySession *videoDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:deviceTypes mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionUnspecified];
    NSArray<AVCaptureDevice* >* devices = videoDeviceDiscoverySession.devices;
    AVCaptureDevice* newVideoDevice = nil;
    // First, look for a device with both the preferred position and device type.
    for (AVCaptureDevice* device in devices) {
        if (device.position == preferredPosition && [device.deviceType isEqualToString:preferredDeviceType]) {
            newVideoDevice = device;
            break;
        }
    }
    
    // Otherwise, look for a device with only the preferred position.
    if (!newVideoDevice) {
        for (AVCaptureDevice* device in devices) {
            if (device.position == preferredPosition) {
                newVideoDevice = device;
                break;
            }
        }
    }
    
    if (newVideoDevice) {
        AVCaptureDeviceInput* videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:newVideoDevice error:NULL];

        [self.captureSession beginConfiguration];

        // Remove the existing device input first, since using the front and back camera simultaneously is not supported.
        [self.captureSession removeInput:self.videoDeviceInput];

        if ([self.captureSession canAddInput:videoDeviceInput]) {
            [self.captureSession addInput:videoDeviceInput];
            self.videoDeviceInput = videoDeviceInput;
        } else {
            [self.captureSession addInput:self.videoDeviceInput];
        }
        [self.captureSession commitConfiguration];
    }
}

- (IBAction)takePhoto:(id)sender {
    [_photoOutput capturePhotoWithSettings:AVCapturePhotoSettings.new delegate:self];
}

- (void)grantAccess{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSLog(@"%zd",status);
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            // The user has not yet been asked for camera access.
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                NSLog(@"%d",granted);
                if (granted) {
                    // setup capture session
                    [self setupCaptureSession];
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
            // The user can't grant access due to restrictions.
            
            break;
        case AVAuthorizationStatusDenied:
            // The user has previously denied access.
            break;
        case AVAuthorizationStatusAuthorized:
            // The user has previously granted access to the camera.
            [self setupCaptureSession];
            break;
        default:
            break;
    }
}

- (void)setupCaptureSession{
    _captureSession = [[AVCaptureSession alloc] init];
    
    [_captureSession beginConfiguration];
    
    [self addInput];
    
    [self addOutput];
    
    [_captureSession commitConfiguration];
    // setup previewView
    self.previewView.videoPreviewLayer.session = _captureSession;
    
    // Note
    // If your app supports multiple interface orientations, use the preview layer’s connection to the capture session to set a videoOrientation matching that of your UI.
    [_captureSession startRunning];
}

- (void)addInput{
    _videoDevice =[AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionUnspecified];
    
    NSError *error = nil;
    _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoDevice error:&error];
    if (!error) {
        if ([_captureSession canAddInput:_videoDeviceInput]) {
            [_captureSession addInput:_videoDeviceInput];
        }
    }else{
        NSLog(@"%@",error);
    }
}

- (void)addOutput{
    _photoOutput = [[AVCapturePhotoOutput alloc] init];
    if (![_captureSession canAddOutput:_photoOutput]) {
        NSLog(@"can not add output");
        return;
    }
    _captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    [_captureSession addOutput:_photoOutput];
    
}

#pragma mark - AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output willBeginCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    // 拍摄准备完毕
    NSLog(@"%s",__FUNCTION__);
}

- (void)captureOutput:(AVCapturePhotoOutput *)output willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    // 曝光开始
    NSLog(@"%s",__FUNCTION__);
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    // 曝光结束
    NSLog(@"%s",__FUNCTION__);
}

/// ios(11.0) 才有用的
- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishProcessingPhoto:(AVCapturePhoto*)photo error:(nullable NSError*)error  API_AVAILABLE(ios(11.0)) {
    NSLog(@"%s",__FUNCTION__);
    // 这个就是HEIF(HEIC)的文件数据,直接保存即可
    NSData *data = photo.fileDataRepresentation;
    UIImage *image = [UIImage imageWithData:data];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:imageV];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = image;
    // 保存图片到相册 UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

//- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error API_DEPRECATED("Use -captureOutput:didFinishProcessingPhoto:error: instead.", ios(10.0, 11.0)) {
//    NSLog(@"%s",__FUNCTION__);
//}


- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishRecordingLivePhotoMovieForEventualFileAtURL:(NSURL *)outputFileURL resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings {
    NSLog(@"%s",__FUNCTION__);
    // 完成 Live Photo 停止拍摄
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingLivePhotoToMovieFileAtURL:(NSURL *)outputFileURL duration:(CMTime)duration photoDisplayTime:(CMTime)photoDisplayTime resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings error:(nullable NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings error:(NSError*)error {
    // 完成拍摄，可以在此处保存
    NSLog(@"%s",__FUNCTION__);
}

@end
