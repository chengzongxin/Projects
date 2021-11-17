//
//  ImageSrech.h
//  ImageStrech
//
//  Created by Joe.cheng on 2021/4/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageSrech : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *btnImgV;

- (void)strech;
@end

NS_ASSUME_NONNULL_END
