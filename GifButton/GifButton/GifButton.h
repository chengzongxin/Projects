//
//  GifButton.h
//  GifButton
//
//  Created by Joe on 2019/8/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 创建一个gifbutton
 _commentBtn = [GifButton buttonWithType:UIButtonTypeCustom];
 _commentBtn.gifName = @"点赞";
 _commentBtn.normalImage = [UIImage imageNamed:@"点赞"];
 _commentBtn.frame = CGRectMake(100, 200, 29, 29);
 _commentBtn.text = @"333333";
 
 // 点击事件
 - (IBAction)clickButton:(GifButton *)sender {
    sender.selected = !sender.isSelected;
    int num = [sender.text intValue];
    if (sender.selected) {
        sender.text = [NSString stringWithFormat:@"%d",num + 1];
    }else{
        sender.text = [NSString stringWithFormat:@"%d",num - 1];
    }
 }
 */
@interface GifButton : UIButton
/* gif图片名字 */
@property (copy, nonatomic) IBInspectable NSString *gifName;
/* 一组动画图片 */
@property (copy, nonatomic) NSArray <UIImage *>* animateImages;
/* 默认图片 */
@property (strong, nonatomic) UIImage *normalImage;
/* 如不传,默认取最后一帧 */
@property (strong, nonatomic) UIImage *selectedImage;
/* 重复次数 */
@property (assign, nonatomic) int animateRepeatCount;
/* 重复时间 */
@property (assign, nonatomic) int animateDuration;
/* 按钮文字 */
@property (strong, nonatomic) UILabel *textLabel;
/* 当前文字 & 设置当前文字 */
@property (copy, nonatomic) NSString *text;

@end

NS_ASSUME_NONNULL_END
