//
//  TMNormalPicker.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/17.
//

#import "TMNormalPicker.h"
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "TMUIExtensions.h"

@interface TMNormalPicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *itemPickerView;

@property (nonatomic, copy)NSArray *(^itemListBlock)(void);
@property (nonatomic, copy)NSString *(^fetchShowStringBlock)(id item, NSInteger idx);
@end

@implementation TMNormalPicker

+ (void)showPickerWithTitle:(NSString *)title
              itemListBlock:(NSArray * _Nonnull (^)(void))itemListBlock
    fetchShowStringFromItem:(NSString * _Nonnull (^)(id _Nonnull, NSInteger))fetchShowStringBlock
          finishSelectBlock:(void (^)(id _Nonnull, NSInteger))finishSelectBlock
               curItemIndex:(NSInteger)idx
         fromViewController:(UIViewController *)fromVc {
    
    NSAssert(itemListBlock, @"itemListBlock can not be nil");
    NSAssert(fetchShowStringBlock, @"fetchShowStringBlock can not be nil");
    NSAssert(finishSelectBlock, @"finishSelectBlock can not be nil");
    
    if (!itemListBlock ||
        !fetchShowStringBlock ||
        !finishSelectBlock) {
        return;
    }
    
    TMNormalPicker *picker = [TMNormalPicker pickerView];
    picker.itemListBlock = itemListBlock;
    picker.fetchShowStringBlock = fetchShowStringBlock;
    picker.title = title;
    [picker loadContentPickerView];
    [picker initItemToIdx:idx];
    
    @TMUI_weakify(picker);
    picker.confirmEventBlockAfterDismiss = ^{
        @TMUI_strongify(picker);
        if (finishSelectBlock) {
            NSInteger selectedIdx = [picker.itemPickerView selectedRowInComponent:0];
            selectedIdx = MAX(selectedIdx, 0);
            finishSelectBlock(picker.itemListBlock()[selectedIdx], selectedIdx);
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

- (void)initItemToIdx:(NSInteger)idx {
    [self.itemPickerView selectRow:idx inComponent:0 animated:NO];
}

#pragma mark - pickerView dataSource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.itemListBlock) {
        return [self.itemListBlock() count];
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

/*
///经过测试发现此方法不能正确的调整字体大小
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSAttributedString *mAttriStr = nil;
    if (self.itemListBlock) {
        id item = self.itemListBlock()[row];
        if (self.fetchShowStringBlock) {
            NSString *str = self.fetchShowStringBlock(item);
            if (str) {
                mAttriStr = [[NSAttributedString alloc] initWithString:str attributes:@{
                    NSFontAttributeName:UIFont(8)
                }];
            }
        }
    }
    return mAttriStr ?: [[NSAttributedString alloc] initWithString:@""];
}
*/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView *thisView = nil;
    if (self.itemListBlock) {
        id item = self.itemListBlock()[row];
        if (self.fetchShowStringBlock) {
            NSString *str = self.fetchShowStringBlock(item, row);
            if (str) {
                UILabel *lbl = nil;
                if ([view isKindOfClass:[UILabel class]]) {
                    lbl = (UILabel*)view;
                }else {
                    lbl = [[UILabel alloc] init];
                    lbl.textAlignment = NSTextAlignmentCenter;
                }
                
                lbl.attributedText = [[NSAttributedString alloc] initWithString:str attributes:@{
                    NSFontAttributeName:UIFont(18)
                }];
                
                return lbl;
            }
        }
    }
        
    return thisView ?: [[UIView alloc] init];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

@end
