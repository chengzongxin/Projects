//
//  UIImage+TMUI.h
//  Pods-TMUIKitDemo
//
//  Created by nigel.ning on 2020/4/15.
//


#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**便捷生成对应的形状的icon图片的枚举值*/
typedef NS_ENUM(NSInteger, TMUIImageShape) {
    TMUIImageShapeOval,                 // 椭圆
    TMUIImageShapeTriangle,             // 三角形
    TMUIImageShapeDisclosureIndicator,  // 列表 cell 右边的箭头
    TMUIImageShapeCheckmark,            // 列表 cell 右边的checkmark
    TMUIImageShapeDetailButtonImage,    // 列表 cell 右边的 i 按钮图片
    TMUIImageShapeNavBack,              // 返回按钮的箭头
    TMUIImageShapeNavClose              // 导航栏的关闭icon
};


/**扩展UIImage方法*/
@interface UIImage (TMUI)

/**
 用于绘制一张图并以 UIImage 的形式返回

 @param size 要绘制的图片的 size，宽或高均不能为 0
 @param opaque 图片是否不透明，YES 表示不透明，NO 表示半透明
 @param scale 图片的倍数，0 表示取当前屏幕的倍数
 @param actionBlock 实际的图片绘制操作，在这里只管绘制就行，不用手动生成 image
 @return 返回绘制完的图片
 */
+ (nullable UIImage *)tmui_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock;


/**
 *  获取当前图片的均色，原理是将图片绘制到1px*1px的矩形内，再从当前区域取色，得到图片的均色。
 *  @link http://www.bobbygeorgescu.com/2011/08/finding-average-color-of-uiimage/ @/link
 *
 *  @return 代表图片平均颜色的UIColor对象
 */
- (UIColor *)tmui_averageColor;


/**
 *  置灰当前图片
 *
 *  @return 已经置灰的图片
 */
- (nullable UIImage *)tmui_grayImage;


/**
 *  设置一张图片的透明度
 *
 *  @param alpha 要用于渲染透明度
 *
 *  @return 设置了透明度之后的图片
 */
- (nullable UIImage *)tmui_imageWithAlpha:(CGFloat)alpha;


/**
 *  保持当前图片的形状不变，使用指定的颜色去重新渲染它，生成一张新图片并返回
 *
 *  @param tintColor 要用于渲染的新颜色
 *
 *  @return 与当前图片形状一致但颜色与参数tintColor相同的新图片
 */
- (nullable UIImage *)tmui_imageWithTintColor:(nullable UIColor *)tintColor;


/**
 *  在当前图片的上下左右增加一些空白（不支持负值），通常用于调节NSAttributedString里的图片与文字的间距
 *  @param extension 要拓展的大小,不支持负值
 *  @return 拓展后的图片
 */
- (nullable UIImage *)tmui_imageWithSpacingExtensionInsets:(UIEdgeInsets)extension;


/**
 *  将原图进行旋转，只能选择上下左右四个方向
 *
 *  @param  direction 旋转的方向
 *
 *  @return 处理完的图片
 */
- (nullable UIImage *)tmui_imageWithOrientation:(UIImageOrientation)direction;

#pragma mark - generate color image
/**
 *  创建一个size为(4, 4)的纯色的UIImage
 *
 *  @param color 图片的颜色
 *
 *  @return 纯色的UIImage
 */
+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color;

/**
 *  创建指定size的纯色的UIImage
 *
 *  @param color 图片的颜色
 *
 *  @param size 指定生成的图片的size
 *
 *  @return 纯色的UIImage
*/
+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color size:(CGSize)size;

/**
 *  创建一个纯色的UIImage
 *
 *  @param  color           图片的颜色
 *  @param  size            图片的大小
 *  @param  cornerRadius    图片的圆角
 *
 * @return 纯色的UIImage
 */
+ (nullable UIImage *)tmui_imageWithColor:(nullable UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

#pragma mark - generate shape image

/**
 *  创建一个指定大小和颜色的形状图片
 *  @param shape 图片形状
 *  @param size 图片大小
 *  @param tintColor 图片颜色
 */
+ (nullable UIImage *)tmui_imageWithShape:(TMUIImageShape)shape size:(CGSize)size tintColor:(nullable UIColor *)tintColor;

#pragma mark - 截图

/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回。注意这里使用的是 view.layer 来渲染图片内容。

 @param view 要截图的 `UIView`

 @return `UIView` 的截图
 
 @warning UIView 的 transform 并不会在截图里生效
 */
+ (nullable UIImage *)tmui_imageWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
