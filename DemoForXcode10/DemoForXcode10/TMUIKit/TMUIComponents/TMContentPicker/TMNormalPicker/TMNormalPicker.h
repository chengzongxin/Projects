//
//  TMNormalPicker.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMContentPicker.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 普通单一项的选择器，一般只有一列数据供选择
 */
@interface TMNormalPicker : TMContentPicker


/// 普通单一项数据选择器初始化及UI显示的便捷方法
/// @param title 选择器顶部的title串，默认为nil
/// @param itemListBlock 选择器的数据源block
/// @param fetchShowStringBlock 某列某行的位置显示的字符串的数据源block
/// @param finishSelectBlock 当点击确定按钮后，等视图完全消失后的业务数据回调
/// @param idx 初始化后需要将相关列的列表数据指定到某一个自定义的初始位置的索引值
/// @param fromVc 需要选择present的vc，内部统一处理为用fromVc.tabbarController作present操作
/// @warning 相关block返回的列表数据，内部不会进行缓存
+ (void)showPickerWithTitle:(NSString *_Nullable)title
              itemListBlock:(NSArray *(^)(void))itemListBlock
    fetchShowStringFromItem:(NSString *(^)(id item, NSInteger idx))fetchShowStringBlock
          finishSelectBlock:(void(^)(id item, NSInteger idx))finishSelectBlock
               curItemIndex:(NSInteger)idx
         fromViewController:(UIViewController *)fromVc;

@end

NS_ASSUME_NONNULL_END
