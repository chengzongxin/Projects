//
//  ViewController.m
//  ImageStrech
//
//  Created by Joe.cheng on 2021/4/20.
//

#import "ViewController.h"
#import "ImageSrech.h"

@interface ViewController ()

@property (nonatomic, strong) ImageSrech *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    
//    UIImage *image = [UIImage imageNamed:@"icon_worker_info_bg"];
//    CGFloat top = 100; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 100; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 伸缩后重新赋值
//    UIImage *strechImg = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    
//    UIImageView *imgV = [[UIImageView alloc] initWithImage:strechImg];
//    imgV.frame = CGRectMake(0, 44, self.view.bounds.size.width, 166);
//    [self.view addSubview:imgV];
    
    
    
    
    ImageSrech *view =  (ImageSrech *)[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ImageSrech class]) owner:self options:nil][0];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 166);
    [self.view addSubview:view];
    _imgV = view;
    
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    [_imgV strech];
//}


@end
