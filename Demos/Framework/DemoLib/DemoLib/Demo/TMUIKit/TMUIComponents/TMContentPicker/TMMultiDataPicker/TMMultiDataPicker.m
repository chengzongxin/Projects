//
//  TMMultiDataPicker.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMMultiDataPicker.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"

@interface TMMultiDataPicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *itemPickerView;

@property (nonatomic, copy)TMMultiDataPickerNumberOfColumnsBlock numberOfColumnsBlock;
@property (nonatomic, copy)TMMultiDataPickerItemListAtColumnBlock itemListAtColumnBlock;
@property (nonatomic, copy)TMMultiDataPickerFetchShowStringFromItemBlock fetchShowStringBlock;

@end

@implementation TMMultiDataPicker

+ (void)showPickerWithTitle:(NSString *)title       numberOfColumnsBlock:(TMMultiDataPickerNumberOfColumnsBlock)numberOfColumnsBlock
itemListAtColumnBlock:(TMMultiDataPickerItemListAtColumnBlock)itemListAtColumnBlock    fetchShowStringFromItem:(TMMultiDataPickerFetchShowStringFromItemBlock)fetchShowStringBlock
          finishSelectBlock:(TMMultiDataPickerFinishSelectBlock)finishSelectBlock
           curItemRowIndexs:(NSArray<NSNumber *> *)curItemRowIndexs
         fromViewController:(UIViewController *)fromVc {
    
    NSAssert(numberOfColumnsBlock, @"numberOfColumnsBlock can not be nil");
    NSAssert(itemListAtColumnBlock, @"itemListAtColumnBlock can not be nil");
    NSAssert(fetchShowStringBlock, @"fetchShowStringBlock can not be nil");
    NSAssert(finishSelectBlock, @"finishSelectBlock can not be nil");
    
    if (!numberOfColumnsBlock ||
        !itemListAtColumnBlock ||
        !fetchShowStringBlock ||
        !finishSelectBlock) {
        return;
    }
    
    TMMultiDataPicker *picker = [TMMultiDataPicker pickerView];
    picker.numberOfColumnsBlock = numberOfColumnsBlock;
    picker.itemListAtColumnBlock = itemListAtColumnBlock;
    picker.fetchShowStringBlock = fetchShowStringBlock;
    picker.title = title;
    [picker loadContentPickerView];
    [picker initItemToRowIdxs:curItemRowIndexs];
    
    @TMUI_weakify(picker);
    picker.confirmEventBlockAfterDismiss = ^{
        @TMUI_strongify(picker);
        if (finishSelectBlock) {
            NSInteger columns = [picker.itemPickerView numberOfComponents];
            NSMutableArray *items = [NSMutableArray array];
            NSMutableArray *idxs = [NSMutableArray array];
            for (NSInteger component = 0; component < columns; ++component) {
                NSInteger selectedIdx = [picker.itemPickerView selectedRowInComponent:component];
                selectedIdx = MAX(selectedIdx, 0);
                NSArray *t_datas = picker.itemListAtColumnBlock(component);
                id item = t_datas[selectedIdx];
                [items addObject:item];
                [idxs addObject:@(selectedIdx)];
            }
            finishSelectBlock(items, idxs);
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

- (void)initItemToRowIdxs:(NSArray<NSNumber *> *)rowIdxs {
    NSInteger columns = self.numberOfColumnsBlock();
    for (NSInteger i = 0; i < columns; ++i) {
        if (i < rowIdxs.count) {
            NSInteger initRowIndex = [rowIdxs[i] integerValue];
            NSInteger rows = [self.itemListAtColumnBlock(i) count];
#if DEBUG
            NSAssert(initRowIndex < rows, @"init idx[%ld] should be less than rows at column[%ld]", initRowIndex, i);
#endif
            if (i < rows) {
                [self.itemPickerView selectRow:initRowIndex inComponent:i animated:NO];
            }
        }
    }
}

#pragma mark - pickerView dataSource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.numberOfColumnsBlock) {
        return self.numberOfColumnsBlock();
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.itemListAtColumnBlock) {
        return [self.itemListAtColumnBlock(component) count];
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *thisView = nil;
    if (self.itemListAtColumnBlock) {
        NSArray *items = self.itemListAtColumnBlock(component);
        id item = items[row];
        if (self.fetchShowStringBlock) {
            NSString *str = self.fetchShowStringBlock(item, component, row);
            if (str) {
                UILabel *lbl = nil;
                if ([view isKindOfClass:[UILabel class]]) {
                    lbl = (UILabel*)view;
                }else {
                    lbl = [[UILabel alloc] init];
                    lbl.textAlignment = NSTextAlignmentCenter;
                }
                
                lbl.attributedText = [[NSAttributedString alloc] initWithString:str attributes:@{
                    NSFontAttributeName:UIFont(22)
                }];
                
                return lbl;
            }
        }
    }
        
    return thisView ?: [[UIView alloc] init];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

@end
