//
//  UIButton+Convenient.h
//  MU
//
//  Created by Joe on 2020/2/13.
//  Copyright © 2020年 Matafy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, MTFYButtonImageTitleStyle) {
    MTFYButtonImageTitleStyleLeft = 0,          //图片在左，文字在右，整体居中。
    MTFYButtonImageTitleStyleRight,             //图片在右，文字在左，整体居中。
    MTFYButtonImageTitleStyleTop,               //图片在上，文字在下，整体居中。
    MTFYButtonImageTitleStyleBottom,            //图片在下，文字在上，整体居中。
    MTFYButtonImageTitleStyleCenterTop,         //图片居中，文字在上距离按钮顶部。
    MTFYButtonImageTitleStyleCenterBottom,      //图片居中，文字在下距离按钮底部。
    MTFYButtonImageTitleStyleCenterUp,          //图片居中，文字在图片上面。
    MTFYButtonImageTitleStyleCenterDown,        //图片居中，文字在图片下面。
    MTFYButtonImageTitleStyleRightLeft,         //图片在右，文字在左，距离按钮两边边距
    MTFYButtonImageTitleStyleLeftRight,         //图片在左，文字在右，距离按钮两边边距
};

typedef NS_ENUM(NSUInteger, OXImagePosition) {
    
    OXImagePositionLeft    = 0, //图片在左，文字在右，默认
    OXImagePositionRight  ,     //图片在右，文字在左
    OXImagePositionTop    ,     //图片在上，文字在下
    OXImagePositionBottom ,     //图片在下，文字在上
    
};

@interface UIButton (Convenient)

/** 快速创建按钮 */
+ (instancetype _Nullable )button;

#pragma mark -
#pragma mark - 便捷设置title, image
@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, copy) NSString * _Nullable image;
- (void)setTitle:(NSString *_Nullable)title;
- (void)setImage:(NSString *_Nullable)image;
- (void)setTitleColor:(UIColor *)titleColor;

/** 快速的绑定事件 */
- (void)addTarget:(nullable id)target action:(nonnull SEL)sel;

/** 设置默认和选中文本 */
- (void)setNormalTitle:(NSString *_Nullable)normalTitle selectedTitle:(NSString *_Nullable)selectedTitle;

/** 设置默认和选中背景色 */
- (void)setNormalBackGroundColor:(UIColor *_Nullable)normalColor selectedBackGroundColor:(UIColor *_Nullable)selectedColor;

/** 设置选中和禁用背景色 */
- (void)setNormalBackGroundColor:(UIColor *_Nullable)normalColor disableBackGroundColor:(UIColor *_Nullable)disableColor;

/** 设置选中和禁用背景色 */
+ (instancetype _Nullable)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font;

/** init */
+ (instancetype _Nullable)buttonWithText:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font backgoundColor:(UIColor *)backgroudColor target:(nullable id)target action:(nonnull SEL)sel;


/**
 图片在上，文字在下
 */
-(void)topImageButton:(UIButton *)btn space:(CGFloat)space;

/**
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 
 @param style 样式
 @param padding 间距
 */
- (void)buttonImageTitleWithStyle:(MTFYButtonImageTitleStyle)style
                          padding:(CGFloat)padding;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(OXImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
