//
//  THKAuthenticationView.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/1/19.
//

#import <UIKit/UIKit.h>
#import "THKIdentityConfiguration.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^THKIdentityViewTapBlock)(NSInteger type);

typedef NS_ENUM(NSInteger, THKIdentityViewStyle) {
    THKIdentityViewStyle_Icon, // 只显示icon，默认位于右下角
    THKIdentityViewStyle_Full, // 完整显示 eg ：V 认证机构
};

/*
 需求描述：
 1.后端增加一个V标识的配置表，随app初始化接口返回，数据结构包含：logo、文字、字体尺寸、字体颜色、背景颜色等；
 2.封装头像右下角的V标识和带文字的V标识，根据type从配置表中匹配对应的数据并展示，从8.15版本开始，都按此方案做；
 */

/// 宽高自适应标识View
/// Full样式，按照Label使用方式（内置Size）不需要设置size约束，可以直接当做Label使用（使用内置Size），如果设置宽度，可能文字会有裁剪（xyz...），高度取icon的图标上下扩大4个像素
/// Icon样式，按照View常规样式，因为每个业务的UI部分头像不一样，需要设置宽高Size，在右下角显示
@interface THKIdentityView : UIView

/// 类方法创建标识View
/// 默认为THKIdentityViewStyle_Icon，只显示右下角V标识，不建议用此方法初始化
+ (instancetype)identityView;

/// 类方法创建标识View
/// 默认为THKIdentityViewStyle_Icon，只显示右下角V标识
/// @param type V标识类型
+ (instancetype)identityViewWithType:(NSInteger)type;

/// 类方法创建标识View
/// @param type V标识类型
/// @param style V标识样式
+ (instancetype)identityViewWithType:(NSInteger)type style:(THKIdentityViewStyle)style;

/// 初始化创建标识View
/// @param type V标识类型
/// @param style V标识样式
- (instancetype)initWithType:(NSInteger)type style:(THKIdentityViewStyle)style;


/// 初始化创建标识View
/// @param type V标识类型
/// @param subType 二级标识分类，有些业务线会一个类型下会对应两个标识，比如11.1设计机构，11.2个人设计师
/// @param style V标识样式
- (instancetype)initWithType:(NSInteger)type subType:(NSInteger)subType style:(THKIdentityViewStyle)style;

/// 标识View点击回调，superView需要UserInteractionEnable = YES才会生效
@property (nonatomic, copy) THKIdentityViewTapBlock tapBlock;

/// 图标偏移
@property (nonatomic, assign) CGPoint iconOffset;

/// 认证标识View尺寸大小
@property (nonatomic, assign, readonly) CGSize viewSize;

@end

NS_ASSUME_NONNULL_END
