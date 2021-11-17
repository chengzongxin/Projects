//
//  THKSegmentControl.h
//  HouseKeeper
//
//  Created by jerry.jiang on 2/29/16.
//  Copyright © 2016 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define_Block.h"

#define BUTTON_START_INDEX (1024)

typedef void(^THKSegmentControlItemEventBlock)(UIButton *button, NSInteger index);

@interface THKSegmentControl : UIControl

/**
 手动点击和外部调用changeValueToIndex:animation:会执行这个block
 */
@property (nonatomic, copy  ) T8TIndexBlock     blockValueChanged;

/**
 当对当前选中的菜单项再次点击时，可响应此回调
 @note 通常情况下不需要此回调，一些特定场景需要处理相同菜单项重复点击的响应逻辑时可赋值
 */
@property (nonatomic, copy  ) T8TIndexBlock     repeatClickItemBlock;

/**
 点击事件的回调
 */
@property (nonatomic, copy  ) THKSegmentControlItemEventBlock     itemClickBlock;

/**
 曝光的回调
 */
@property (nonatomic, copy  ) THKSegmentControlItemEventBlock     itemExposeBlock;

///赋值顺序很重要，首页会用到；改的时候需要注意
@property (nonatomic, assign) NSInteger         selectedIndex;

/**
 如果要修改游标距底部的距离，可以设置如：indicatorView.y -= 4;
 */
@property (nonatomic, strong) UIView            *indicatorView;

/**
 设置按钮选中时的背景色，默认为无颜色
 */
@property (nonatomic, strong) UIColor           *selectedBackgroundColor;

/**
 记录上一次被选中的按钮，主要是开发给子类用
 */
@property (nonatomic, strong, readonly)   UIButton          *lastSelectedButton;

@property (nonatomic, strong, readonly) UIScrollView      *scrollView;

/**
 返回生成的button
 */
@property (nonatomic, copy, readonly) NSArray<UIButton *> *segmentButtons;

// 选中字体的放大倍数
@property (nonatomic, assign) CGFloat scale;

/**
 设置segment元素的最小宽度。默认的按钮宽度width=文字宽度+20，如果指定了最小宽度，则取MAX(width,minItemWidth)
 */
@property (nonatomic, assign) CGFloat minItemWidth;

/**
 自动居中显示，默认为NO
 当所有按钮的总宽度小于容器宽度时，默认按钮是靠左显示的，
 如果设置了该值为YES，则会自动修改每个按钮的宽度，保证所有按钮宽度之和等于容器宽度，从而保证按钮都居中显示
 */
@property (nonatomic, assign) BOOL autoAlignmentCenter;

/**
 默认是THKSegmentControlStylePlain样式，如果不需要设置样式，直接用initWithFrame初始化即可
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setSegmentTitles:(NSArray *)segmentTitles;

/**
 设置选中的button
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**
 改变选项值，它执行setSelectedIndex:animated后还会触发blockValueChanged和UIControlEventValueChanged事件
 */
- (void)changeValueToIndex:(NSInteger)index animated:(BOOL)animated;

/**
 设置字体颜色
 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

/**
 设置字体大小
 */
- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;

/**
 自定义indicatorView移动动画
 */
- (void)setTransitionAnimation:(void(^)(UIView *indicator, CGRect indicatorTargetFrame))animation;

/**
 获取当前选中的按钮,
 index=-1表示返回当前选中的Button
 */
- (UIButton *)segmentButtonAtIndex:(NSInteger)index;

/**
 获取当前选中按钮的文本
 */
- (NSString *)titleForSelected;

@end

