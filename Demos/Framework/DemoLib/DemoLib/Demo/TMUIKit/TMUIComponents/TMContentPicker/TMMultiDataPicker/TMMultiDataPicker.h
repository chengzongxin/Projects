//
//  TMMultiDataPicker.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMContentPicker.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger (^TMMultiDataPickerNumberOfColumnsBlock)(void);
typedef NSArray * _Nonnull (^TMMultiDataPickerItemListAtColumnBlock)(NSInteger columnIndex);
typedef NSString * _Nonnull (^TMMultiDataPickerFetchShowStringFromItemBlock)(id item, NSInteger columnIndex, NSInteger rowIndex);
typedef void (^TMMultiDataPickerFinishSelectBlock)(NSArray *selectedItems, NSArray<NSNumber*> *selectedRowIndexs);

/**
 多列数据选择器
 每列的数据组都独立，某列数据变化时，不影响其它列的数据
 @note  户型选择器可用此，几室 、几厅、几厨、几卫，列数据项间不联动变化关系
 */
@interface TMMultiDataPicker : TMContentPicker


/// 多表数据选择器初始化及UI显示的便捷方法
/// @param title 选择器顶部的title串，默认为nil
/// @param numberOfColumnsBlock  选择器对应多少列数据的数据源block
/// @param itemListAtColumnBlock 选择器对应在某列下的列表数据的数据源block
/// @param fetchShowStringBlock 某列某行的位置显示的字符串的数据源block
/// @param finishSelectBlock 当点击确定按钮后，等视图完全消失后的业务数据回调
/// @param curItemRowIndexs 初始化后需要将相关列的列表数据指定到某一个自定义的初始位置的索引值列表(有多少列就按列的顺序传入对应的列表数据初始位置索引) | 若传入的数组个数比columns列数大，则只会取前columns个作处理；若传入的数组个数比columns列数小，则按顺序赋值对应指定的索引值，后面的默认选择为row=0; 注意-传入初始的值若超出对应列里的数据列表数则会抛出异常
/// @param fromVc 需要选择present的vc，内部统一处理为用fromVc.tabbarController作present操作
/// @warning 相关block返回的列表数据，内部不会进行缓存
+ (void)showPickerWithTitle:(NSString * _Nullable)title   numberOfColumnsBlock:(TMMultiDataPickerNumberOfColumnsBlock)numberOfColumnsBlock
      itemListAtColumnBlock:(TMMultiDataPickerItemListAtColumnBlock)itemListAtColumnBlock    fetchShowStringFromItem:(TMMultiDataPickerFetchShowStringFromItemBlock)fetchShowStringBlock
          finishSelectBlock:(TMMultiDataPickerFinishSelectBlock)finishSelectBlock
           curItemRowIndexs:(NSArray<NSNumber *> * _Nullable)curItemRowIndexs
         fromViewController:(UIViewController *)fromVc;

@end

NS_ASSUME_NONNULL_END
