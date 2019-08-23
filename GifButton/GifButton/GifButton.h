//
//  GifButton.h
//  GifButton
//
//  Created by Joe on 2019/8/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GifButton : UIButton
/* gif图片名字 */
@property (copy, nonatomic) IBInspectable NSString *gifName;
/* 默认图片 */
@property (strong, nonatomic) UIImage *normalImage;
/* 如不传,默认取最后一帧 */
@property (strong, nonatomic) UIImage *selectedImage;
/* 重复次数 */
@property (assign, nonatomic) int animateRepeatCount;
/* 重复时间 */
@property (assign, nonatomic) int animateDuration;

@end

NS_ASSUME_NONNULL_END
