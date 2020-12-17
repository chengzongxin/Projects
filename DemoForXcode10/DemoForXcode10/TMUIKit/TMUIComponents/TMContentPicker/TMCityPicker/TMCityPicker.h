//
//  TMCityPicker.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/20.
//

#import "TMContentPicker.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const TMCityPickerTitle;

typedef NSArray * _Nonnull (^TMCityPickerProvinceItemListBlock)(void);
typedef NSArray * _Nonnull (^TMCityPickerCityItemListAtProvinceBlock)(id provinceItem, NSInteger provinceIndex);

typedef NSString * _Nonnull (^TMCityPickerFetchShowStringForProvinceBlock)(id provinceItem, NSInteger provinceIndex);
typedef NSString * _Nonnull (^TMCityPickerFetchShowStringForCityBlock)(id cityItem, NSInteger cityIndex, id inProvinceItem, NSInteger provinceIndex);

typedef void (^TMCityPickerFinishSelectBlock)(id selectedProvinceItem, NSInteger selectedProvinceIndex, id selectedCityItem, NSInteger selectedCityIndex);

/**
 城市选择器视图
 主要分两列 省-市，当省变化时对应的市列表数据要联动变化
 */
@interface TMCityPicker : TMContentPicker



/// 城市选择器初始化及显示的便捷方法
/// @param title 选择器顶部的title串, 若为nil，则会取默认的title - 选择城市
/// @param provinceItemListBlock 获取省份列表的block
/// @param cityItemListAtProvinceBlock 获取某一省份下城市名列表的block
/// @param fetchShowStringForProvinceBlock 获取省份项里用于显示到选择器对应视图上的字符信息串的block， 通常返回省名
/// @param fetchShowStringForCityBlock 获取城市项里用于显示到选择器对应视图上的字符信息串的block，通常返回城市名
/// @param finishSelectBlock 点击确定后的数据逻辑回调，会将当前选择省份项数据及对应省份索引值，省份下选择的城市项及对应城市索引值返回到上层的block
/// @param curProvinceItemIndex 可指定初始时定位显示到某索引位置的省份数据，默认显示索引位置为0的省份
/// @param curCityItemIndex 可指定初始时定位显示到某索引位置的城市数据，默认显示索引位置为0的城市，此城市列表与省份列表是有关联关系
/// @param fromVc 需要选择present的vc，内部统一处理为用fromVc.tabbarController作present操作
+ (void)showPickerWithTitle:(NSString * _Nullable)title
      provinceItemListBlock:(TMCityPickerProvinceItemListBlock)provinceItemListBlock
cityItemListAtProvinceBlock:(TMCityPickerCityItemListAtProvinceBlock)cityItemListAtProvinceBlock
fetchShowStringForProvinceItem:(TMCityPickerFetchShowStringForProvinceBlock)fetchShowStringForProvinceBlock
 fetchShowStringForCityItem:(TMCityPickerFetchShowStringForCityBlock)fetchShowStringForCityBlock
          finishSelectBlock:(TMCityPickerFinishSelectBlock)finishSelectBlock
       curProvinceItemIndex:(NSInteger)curProvinceItemIndex
           curCityItemIndex:(NSInteger)curCityItemIndex
         fromViewController:(UIViewController *)fromVc;


@end

NS_ASSUME_NONNULL_END
