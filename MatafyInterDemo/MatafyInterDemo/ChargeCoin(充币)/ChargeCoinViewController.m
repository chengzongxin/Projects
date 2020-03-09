//
//  ChargeCoinViewController.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/1/14.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ChargeCoinViewController.h"
#import "ChoiceCoinViewController.h"
#import "ChargeHistoryViewController.h"

@interface ChargeCoinViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ChargeCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充币";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStyleDone target:self action:@selector(recordClick)];
    
    self.addressLabel.text = @"chengzongxin";
    self.QRImageView.image = [self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:self.addressLabel.text] withSize:self.QRImageView.bounds.size.width];
}

- (void)recordClick{
    NSLog(@"%s",__FUNCTION__);
    [self.navigationController pushViewController:ChargeHistoryViewController.new animated:YES];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%s",__FUNCTION__);
    [self.navigationController pushViewController:ChoiceCoinViewController.new animated:YES];
    return NO;
}

// 复制地址
- (IBAction)copyAddress:(id)sender {
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.addressLabel.text;
}


#pragma mark - 生成二维码
- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
