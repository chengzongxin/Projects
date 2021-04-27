//
//  THKAuthenticationView.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/1/19.
//

#import <UIKit/UIKit.h>
#import "THKView.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^THKIdentityViewTapBlock)(NSInteger type);

typedef NS_ENUM(NSInteger, THKIdentityViewStyle) {
    THKIdentityViewStyle_Icon = 0, // 只显示icon，默认位于右下角
    THKIdentityViewStyle_Full = 1, // 完整显示 eg ：V 认证机构
};

/*
 需求描述：
 1.后端增加一个V标识的配置表，随app初始化接口返回，数据结构包含：logo、文字、字体尺寸、字体颜色、背景颜色等；
 2.封装头像右下角的V标识和带文字的V标识，根据type从配置表中匹配对应的数据并展示，从8.15版本开始，都按此方案做；
 */


/// 标识View，支持 Masonry，Frame，Xib，懒加载等形式
/// Full样式，按照Label使用方式（内置Size）不需要设置size约束，可以直接当做Label使用（使用内置Size），如果设置宽度，可能文字会有裁剪（xyz...），高度取icon的图标上下扩大4个像素
/// Icon样式，按照View常规样式，可以使用THKAvatarView，内部已集成标识组件，因为每个业务的UI部分头像大小不一样，所以需要外部设置宽高Size，在右下角显示
@interface THKIdentityView : THKView

/// 类方法创建标识View，一般使用场景在懒加载形式，后赋值
/// 默认为THKIdentityViewStyle_Icon，只显示右下角V标识，不建议用此方法初始化，
/// 如果使用此方法，后续数据回调时须调用【 - (void)setType:(NSInteger)type subType:(NSInteger)subType 】设置标识类型
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

/// 获取认证标识View尺寸大小
@property (nonatomic, assign, readonly) CGSize viewSize;

/// 某些场景下是先通过懒加载创建IdentityView，后续数据回调再刷新IdentityVIew，需要把类型传过来，调用这个方法
/// @param type V标识类型
- (void)setType:(NSInteger)type;

/// 某些场景下是先通过懒加载创建IdentityView，后续数据回调再刷新IdentityVIew，需要把类型传过来，调用这个方法
/// @param type V标识类型
/// @param subType 二级标识分类, 没有传0即可，有些业务线会一个类型下会对应两个标识，比如11.1设计机构，11.2个人设计师
- (void)setType:(NSInteger)type subType:(NSInteger)subType;

/// V 标识样式，THKIdentityViewStyle 类型，只显示小图标Icon或者显示图标和文本Full
/// XIB 初始化时使用，在面板选择style类型，0=Icon，1=Full,
/// 后期调用setType方法显示标识
@property (nonatomic, assign) IBInspectable NSInteger style;

@end

NS_ASSUME_NONNULL_END
