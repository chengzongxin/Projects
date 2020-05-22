//
//  CameraViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/20.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinCameraViewController.h"
#import <Photos/Photos.h>
#import "SCPermissionsView.h"
#import "FacePreviewView.h"
#import "SkinViewModel.h"
#import "Slider.h"

@interface SkinCameraViewController () <SCPermissionsViewDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) SCPermissionsView *permissionsView;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDevice *videoDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoDeviceInput;
//@property (strong, nonatomic) AVCapturePhotoOutput *photoOutput;
@property (strong, nonatomic) AVCaptureVideoDataOutput *videoOutput;
@property (strong, nonatomic) FacePreviewView *previewView;

@property (strong, nonatomic) Slider *scaleSlider;
@property (strong, nonatomic) UIImage *lastImage;

@end

@implementation SkinCameraViewController

#pragma mark - LifeCycle Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.permissionsView.hasAllPermissions) { // 没有权限
        [self.view addSubview:self.permissionsView];
    } else {
        [self setupCaptureSession];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"switch_camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(switchCamere:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupCaptureSession{
    // setup previewView
    dispatch_async(dispatch_get_main_queue(), ^{

        self.captureSession = [[AVCaptureSession alloc] init];
        
        [self.captureSession beginConfiguration];
        
        [self addInput];
        
        [self addOutput];
        
        [self.captureSession commitConfiguration];
        
        [self.view addSubview:self.previewView];
        self.previewView.videoPreviewLayer.session = self.captureSession;
        self.previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        __weak __typeof__(self)weakSelf = self;
        self.previewView.countDown = ^{
            [weakSelf snapshot];
        };
        
        // Note
        // If your app supports multiple interface orientations, use the preview layer’s connection to the capture session to set a videoOrientation matching that of your UI.
        [self.captureSession startRunning];
        
        // 放到preview 上层
//        [self.view addSubview:self.switchCameraButton];
        
        [self.view addSubview:self.scaleSlider];
    });
    
}


- (void)addInput{
    _videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    
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
//    _photoOutput = [[AVCapturePhotoOutput alloc] init];
    _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(0, 0)];
    if (![_captureSession canAddOutput:_videoOutput]) {
        NSLog(@"can not add output");
        return;
    }
    _captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    [_captureSession addOutput:_videoOutput];
    
}


#pragma mark - Actions

- (void)snapshot{
//    [_photoOutput capturePhotoWithSettings:AVCapturePhotoSettings.new delegate:self];
    
    AVCaptureDevicePosition currentPosition = self.videoDeviceInput.device.position;
    if (currentPosition == AVCaptureDevicePositionFront) {
       _lastImage = [UIImage imageWithCGImage:_lastImage.CGImage scale:_lastImage.scale orientation:UIImageOrientationLeftMirrored];
    }
    
    [_captureSession stopRunning];
    
    [SkinViewModel applyAnalysisCommand:_lastImage deviceNo:@"123" analysisPersonnelType:@"analysis_me" success:^(id  _Nonnull data) {
        NSLog(@"%@",data);
    } fail:^(NSString * _Nonnull message) {
        NSLog(@"%@",message);
    }];
}

- (void)switchCamere:(id)sender {
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

- (void)scaleCamera:(UISlider *)sender{
    NSLog(@"%f",sender.value);
    NSError *error;
    float factor = sender.value;
    if ([_videoDeviceInput.device lockForConfiguration:&error]) {
        
        if (error) {
            NSLog(@"%@",error);
        }
        
        if (_videoDeviceInput.device.activeFormat.videoMaxZoomFactor > factor && factor >= 1.0) {
            [_videoDeviceInput.device rampToVideoZoomFactor:factor withRate:4.0];
        }
        [_videoDeviceInput.device unlockForConfiguration];
    }
}

#pragma mark - Delegate
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
//    NSLog(@"%s",__FUNCTION__);
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    [self detectFaceWithImage:image];
    _lastImage = image;
}

// 通过抽样缓存数据创建一个UIImage对象
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    //CIImage -> CGImageRef -> UIImage
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);  //拿到缓冲区帧数据
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:imageBuffer];            //创建CIImage对象
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];           //创建上下文
    CGImageRef cgImageRef = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer))];
    UIImage *result = [[UIImage alloc] initWithCGImage:cgImageRef scale:UIScreen.mainScreen.scale orientation:UIImageOrientationRight];  //创建UIImage对象
    CGImageRelease(cgImageRef);  //释放上下文
    return result;
}

/**识别脸部*/
-(NSArray *)detectFaceWithImage:(UIImage *)faceImg
{
    //此处是CIDetectorAccuracyHigh，若用于real-time的人脸检测，则用CIDetectorAccuracyLow，更快
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil
                                                  options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    CIImage *ciimg = [CIImage imageWithCGImage:faceImg.CGImage];
    NSArray *features = [faceDetector featuresInImage:ciimg];

    CIFaceFeature *faceFeature = [features firstObject];
    if (faceFeature) {
//        NSLog(@"bounds                  : %@",NSStringFromCGRect(faceFeature.bounds));
//        NSLog(@"hasLeftEyePosition      : %d",faceFeature.hasLeftEyePosition);
//        NSLog(@"leftEyePosition         : %@",NSStringFromCGPoint(faceFeature.leftEyePosition));
//        NSLog(@"hasRightEyePosition     : %d",faceFeature.hasRightEyePosition);
//        NSLog(@"rightEyePosition        : %@",NSStringFromCGPoint(faceFeature.rightEyePosition));
//        NSLog(@"hasMouthPosition        : %d",faceFeature.hasMouthPosition);
//        NSLog(@"mouthPosition           : %@",NSStringFromCGPoint(faceFeature.mouthPosition));
//        NSLog(@"hasTrackingID           : %d",faceFeature.hasTrackingID);
//        NSLog(@"trackingID              : %d",faceFeature.trackingID);
//        NSLog(@"hasTrackingFrameCount   : %d",faceFeature.hasTrackingFrameCount);
//        NSLog(@"trackingFrameCount      : %d",faceFeature.trackingFrameCount);
//        NSLog(@"hasFaceAngle            : %d",faceFeature.hasFaceAngle);
//        NSLog(@"faceAngle               : %frightEyeClosed",faceFeature.faceAngle);
//        NSLog(@"hasSmile                : %d",faceFeature.hasSmile);
//        NSLog(@"leftEyeClosed           : %d",faceFeature.leftEyeClosed);
//        NSLog(@"rightEyeClosed          : %d",faceFeature.rightEyeClosed);
//        NSLog(@"\n\n\n");
        
        //这里不考虑性能 直接怼Image
           dispatch_async(dispatch_get_main_queue(), ^{

               self.previewView.facePosition = faceFeature.bounds;
//               UIImageWriteToSavedPhotosAlbum(faceImg, nil, nil, nil);
//               [self.captureSession startRunning];
           });
        

//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        UIView *view = [[UIView alloc] initWithFrame:faceFeature.bounds];
//        view.backgroundColor = UIColor.orangeColor;
//        [self.view addSubview:view];
//        [self.captureSession stopRunning];
    }
    return features;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - getter/setter

- (SCPermissionsView *)permissionsView {
    if (_permissionsView == nil) {
        _permissionsView = [[SCPermissionsView alloc] initWithFrame:self.view.bounds];
        _permissionsView.delegate = self;
    }
    return _permissionsView;
}
// PermissionView 权限回调
- (void)permissionsViewDidHasAllPermissions:(SCPermissionsView *_Nullable)pv{}

- (FacePreviewView *)previewView{
    if (_previewView == nil) {
        _previewView = [[FacePreviewView alloc] initWithFrame:self.view.bounds];
        _previewView.layer.zPosition = -1;
    }
    return _previewView;
}


- (Slider *)scaleSlider{
    if (!_scaleSlider) {
        _scaleSlider = [[Slider alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 22 - 10, 64 + 40 + 30 + 30, 100, 12)];
        _scaleSlider.minimumValue = 0;
        _scaleSlider.maximumValue = 10;
        [_scaleSlider addTarget:self action:@selector(scaleCamera:) forControlEvents:UIControlEventValueChanged];
        //将其顺时针旋转90度，这下就变成纵向的了
        _scaleSlider.transform = CGAffineTransformMakeRotation(M_PI_2);
//        _scaleSlider.frame = CGRectMake(self.view.bounds.size.width - 44 - 10, 64 + 40 + 30 + 30, 200, 20);
        CGRect frame = _scaleSlider.frame;
        frame.origin.x = self.view.bounds.size.width - 22 - 10;
        _scaleSlider.frame = frame;
    }
    return _scaleSlider;
}

@end
