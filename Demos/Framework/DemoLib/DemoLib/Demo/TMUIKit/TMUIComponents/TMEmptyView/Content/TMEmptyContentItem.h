//
//  TMEmptyContentItem.h
//  Masonry
//
//  Created by nigel.ning on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "TMEmptyContentItemProtocol.h"
#import "TMEmptyDefine.h"
#import "TMUIKitDefines.h"

NS_ASSUME_NONNULL_BEGIN

/**
 遵循TMEmptyContentItemProtocol协议的数据类
 @note 外部若有其它自定义的空态样式则可选择自行实现协议 或 直接使用此类进行相关数据的自定义赋值
 */
@interface TMEmptyContentItem : NSObject<TMEmptyContentItemProtocol>

/**
 便捷生成对应type类型的空态视图对象,内部会处理相关需要显示的内容及UI位置等.
 */
+ (instancetype)itemWithEmptyType:(TMEmptyContentType)type;

/**
 若外部使用方法初始化，则相关具体数据内容需要自行赋值.
 */
+ (instancetype)itemWithEmptyImg:(UIImage *)img emptyImgSize:(CGSize)imgSize;

#pragma mark - public helper methods
+ (UIImage *)emptyImageByType:(TMEmptyContentType)type;
+ (NSString *)emptyTitleByType:(TMEmptyContentType)type;
+ (NSString *)emptyDescByType:(TMEmptyContentType)type;
+ (UIImage *)emptyNavBackIconByType:(TMEmptyContentType)type;

@end

NS_ASSUME_NONNULL_END
