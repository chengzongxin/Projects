//
//  TMCityPicker.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/20.
//

#import "TMCityPicker.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"

NSString *const TMCityPickerTitle = @"选择城市";


@interface TMCityPicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *itemPickerView;

@property (nonatomic, copy)TMCityPickerProvinceItemListBlock provinceItemListBlock;
@property (nonatomic, copy)TMCityPickerCityItemListAtProvinceBlock cityItemListAtProvinceBlock;

@property (nonatomic, copy)TMCityPickerFetchShowStringForProvinceBlock fetchShowStringForProvinceBlock;
@property (nonatomic, copy)TMCityPickerFetchShowStringForCityBlock fetchShowStringForCityBlock;

@property (nonatomic, assign)NSInteger curProvinceIndex, curCityIndex;

@end

@implementation TMCityPicker

+ (void)showPickerWithTitle:(NSString * _Nullable)title
      provinceItemListBlock:(TMCityPickerProvinceItemListBlock)provinceItemListBlock
cityItemListAtProvinceBlock:(TMCityPickerCityItemListAtProvinceBlock)cityItemListAtProvinceBlock
fetchShowStringForProvinceItem:(TMCityPickerFetchShowStringForProvinceBlock)fetchShowStringForProvinceBlock
 fetchShowStringForCityItem:(TMCityPickerFetchShowStringForCityBlock)fetchShowStringForCityBlock
          finishSelectBlock:(TMCityPickerFinishSelectBlock)finishSelectBlock
       curProvinceItemIndex:(NSInteger)curProvinceItemIndex
           curCityItemIndex:(NSInteger)curCityItemIndex
         fromViewController:(UIViewController *)fromVc {
    
    NSAssert(provinceItemListBlock, @"provinceItemListBlock can not be nil");
    NSAssert(cityItemListAtProvinceBlock, @"cityItemListAtProvinceBlock can not be nil");
    NSAssert(fetchShowStringForProvinceBlock, @"fetchShowStringForProvinceBlock can not be nil");
    NSAssert(fetchShowStringForCityBlock, @"fetchShowStringForCityBlock can not be nil");
    NSAssert(finishSelectBlock, @"finishSelectBlock can not be nil");
    
    if (!provinceItemListBlock ||
        !cityItemListAtProvinceBlock ||
        !fetchShowStringForProvinceBlock ||
        !fetchShowStringForCityBlock ||
        !finishSelectBlock) {
        return;
    }
    
    TMCityPicker *picker = [TMCityPicker pickerView];
    picker.provinceItemListBlock = provinceItemListBlock;
    picker.cityItemListAtProvinceBlock = cityItemListAtProvinceBlock;
    picker.fetchShowStringForProvinceBlock = fetchShowStringForProvinceBlock;
    picker.fetchShowStringForCityBlock = fetchShowStringForCityBlock;
    picker.title = title ?: TMCityPickerTitle;
    [picker loadContentPickerView];
    [picker initItemToProvinceIndex:curProvinceItemIndex cityIndex:curCityItemIndex];
    
    @TMUI_weakify(picker);
    picker.confirmEventBlockAfterDismiss = ^{
        @TMUI_strongify(picker);
        if (finishSelectBlock) {
            NSArray *provinces = picker.provinceItemListBlock();
            NSInteger provinceIndex = [picker.itemPickerView selectedRowInComponent:0];
            id provinceItem = provinces[provinceIndex];
            NSArray *citys = picker.cityItemListAtProvinceBlock(provinces[provinceIndex], provinceIndex);
            NSInteger cityIndex = [picker.itemPickerView selectedRowInComponent:1];
            id cityItem = citys[cityIndex];
            
            finishSelectBlock(provinceItem, provinceIndex, cityItem, cityIndex);
        }
    };
    [picker showFromViewController:fromVc];
    
}

- (void)loadContentPickerView {
    self.itemPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, TMUI_SCREEN_WIDTH, 216)];
    self.itemPickerView.dataSource = self;
    self.itemPickerView.delegate = self;
    self.contentView = self.itemPickerView;
    [self.itemPickerView reloadAllComponents];
}

- (void)initItemToProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex {
    NSArray *provinces = self.provinceItemListBlock();
    NSArray *citys = nil;
    if (provinceIndex > 0 && provinceIndex < provinces.count) {
        self.curProvinceIndex = provinceIndex;
        citys = self.cityItemListAtProvinceBlock(provinces[provinceIndex], provinceIndex);
        [self.itemPickerView reloadComponent:0];
        [self.itemPickerView selectRow:provinceIndex inComponent:0 animated:NO];
    }
    if (cityIndex >= 0 && cityIndex < citys.count) {
        self.curCityIndex = cityIndex;
        [self.itemPickerView reloadComponent:1];
        [self.itemPickerView selectRow:cityIndex inComponent:1 animated:NO];
    }
}

#pragma mark - pickerView dataSource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *provinces = self.provinceItemListBlock();
    if (component == 0) {
        //省
        return provinces.count;
    }else if (component == 1) {
        //市
        NSArray *citys = self.cityItemListAtProvinceBlock(provinces[self.curProvinceIndex], self.curProvinceIndex);
        return citys.count;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.curProvinceIndex = row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
    }else {
        self.curCityIndex = row;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *thisView = nil;
    NSString *showStr = nil;
    
    NSArray *provinces = self.provinceItemListBlock();
    if (component == 0) {
        id provinceItem = provinces[row];
        showStr = self.fetchShowStringForProvinceBlock(provinceItem, row);
    }else if (component == 1) {
        id provinceItem = provinces[self.curProvinceIndex];
        NSArray *citys = self.cityItemListAtProvinceBlock(provinces[self.curProvinceIndex], self.curProvinceIndex);
        
#if DEBUG
        NSAssert(row < citys.count, @"row should be less than citys.count");
#endif
        
        if (row < citys.count) {
            id cityItem = citys[row];
            showStr = self.fetchShowStringForCityBlock(cityItem, row, provinceItem, self.curProvinceIndex);
        }
    }
    
    
    if (showStr) {
        UILabel *lbl = nil;
        if ([view isKindOfClass:[UILabel class]]) {
            lbl = (UILabel*)view;
        }else {
            lbl = [[UILabel alloc] init];
            lbl.textAlignment = NSTextAlignmentCenter;
        }
        
        lbl.attributedText = [[NSAttributedString alloc] initWithString:showStr attributes:@{
            NSFontAttributeName:UIFont(22)
        }];
        
        return lbl;
    }
        
    return thisView ?: [[UIView alloc] init];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

@end
