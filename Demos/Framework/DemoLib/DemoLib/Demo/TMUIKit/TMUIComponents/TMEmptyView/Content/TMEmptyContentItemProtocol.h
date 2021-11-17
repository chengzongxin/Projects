//
//  TMEmptyContentItemProtocol.h
//  Masonry
//
//  Created by nigel.ning on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TMEmptyDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TMEmptyContentItemProtocol <NSObject>

#pragma mark - 空白页占位图配置

@property (nonatomic, assign)CGFloat contentCenterOffsetY;///<  具体展示的内容块整体Y轴上居中位置后的偏移参数，若为0表示整体居中效果，若<0表示居中上移，>0表示居中下移 | 按设计稿此值通常会被赋值为默认值-70，即表示居中位置上移70pt

@property (nonatomic, assign, readonly)CGSize emptyImgSize;///< 返回空白页相关提示图片视图显示的尺寸，按显示的pt为准

/** 图片底部与标题顶部之间的间距，当为0时，会按默认值24处理
 @note 部分特定UI效果，可外部指定其间距值
 */
@property (nonatomic, assign)NSInteger distanceBetweenImgBottomAndTitleTop;

/** 空态页背景底色
 @note 若为nil，则在展示时会取whiteColor作为底色,默认为nil
 */
@property (nonatomic, strong, nullable)UIColor *emptyBackgroundColor;

/** 全屏空态页时，若有nav且系统导航条隐藏，则需要外部根据实际的背景色赋值合适的icon
 @note 若有type进行内部接口初始化的对象，则此库内部会给定合适的icon
 @note 通常情况下，外部不用修改此值
 */
@property (nonatomic, strong, nullable)UIImage *navBackIcon;

@property (nonatomic, strong, readonly)UIImage *emptyImg;///<  返回空白页相关的提示图片对象

#pragma mark - 空白页占位图下方的标题串配置 | 当富文本有值时优先取富文本展示
@property (nonatomic, copy, nullable)NSString *title;///< 空白页显示的在占位图下方的标题串

@property (nonatomic, copy, nullable)NSAttributedString *attributedTitle;///< 自定义标题的富文本串，若有值则优先显示富文本串标题

#pragma mark - 空白页标题串下方的子描述串配置 | 当富文本有值时优先取富文本展示
@property (nonatomic, copy, nullable)NSString *desc;///< 空白页显示在标题串下方的子描述串

@property (nonatomic, copy, nullable)NSAttributedString *attributedDesc;///< 自定义子描述串的富文本串， 若有值则优先显示富文本子描述串

#pragma mark - 整个空白页提示视图点击后的回调配置
@property (nonatomic, copy, nullable)void (^clickEmptyBlock)(void);

#pragma mark - 提供单独更新图片及图片size的接口

- (void)updateImage:(UIImage *)img;
- (void)updateImageFromType:(TMEmptyContentType)type;
- (void)updateImageSize:(CGSize)imgSize;

#pragma mark - 若初始化时以默认NoData而在自定义回调里又需要调整为其它类型则可以用以下方法直接更新到对应的图片、文案

/**以新类型对应的图片及文案更新当前已有的数据赋值*/
- (void)updateEmptyInfoFromType:(TMEmptyContentType)type;

@end

NS_ASSUME_NONNULL_END
