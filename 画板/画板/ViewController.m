//
//  ViewController.m
//  画板
//
//  Created by Joe on 2019/7/8.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}
- (IBAction)setLineColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)photo:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSLog(@"%@",info);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
//    [self.drawView setImage:img];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIView *view = [[UIView alloc] initWithFrame:self.drawView.frame];
    view.backgroundColor = UIColor.clearColor;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero,view.frame.size}];
    imageV.image = img;
    [self.view addSubview:view];
    [view addSubview:imageV];
    // 添加手势
    imageV.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imageV addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [imageV addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [imageV addGestureRecognizer:rotation];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imageV addGestureRecognizer:longPress];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"%s",__FUNCTION__);
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint curP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, curP.x, curP.y);
    // 复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    
    [pinch setScale:1];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation{
    rotation.view.transform = CGAffineTransformMakeRotation(rotation.rotation);
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.5 animations:^{
            longPress.view.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                longPress.view.alpha = 1;
            } completion:^(BOOL finished) {
                
                UIGraphicsBeginImageContextWithOptions(longPress.view.superview.frame.size, NO, 0);
                [longPress.view.superview.layer renderInContext:UIGraphicsGetCurrentContext()];
                UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                [longPress.view.superview removeFromSuperview];
                [longPress.view removeFromSuperview];
                
                [self.drawView setImage:resultImg];
                
            }];
        }];
        
    }
}

- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0);
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(resultImg, nil, nil, nil);
}



@end
