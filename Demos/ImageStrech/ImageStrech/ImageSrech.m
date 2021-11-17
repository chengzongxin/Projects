//
//  ImageSrech.m
//  ImageStrech
//
//  Created by Joe.cheng on 2021/4/20.
//

#import "ImageSrech.h"

@implementation ImageSrech

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self strech];
}

- (void)strech{
    
    
    UIImage *image = [UIImage imageNamed:@"icon_worker_info_bg"];
    CGFloat top = 100; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 100; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    UIImage *strechImg = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
//    // 左端盖宽度
//    NSInteger leftCapWidth = image.size.width * 0.5f;
//    // 顶端盖高度
//    NSInteger topCapHeight = image.size.height * 0.5f;
//    // 重新赋值
//    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
//
//    [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];

    _imageV.image = strechImg;
    
    NSLog(@"%@",_imageV);
//    [_btnImgV setImage:strechImg forState:UIControlStateNormal];
//    _imageV.contentMode = UIViewContentModeScaleAspectFill;
//    [_imageV sizeToFit];
//    [self layoutIfNeeded];
}

@end
