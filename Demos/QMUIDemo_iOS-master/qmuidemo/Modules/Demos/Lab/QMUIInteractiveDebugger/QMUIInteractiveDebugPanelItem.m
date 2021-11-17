//
//  QMUIInteractiveDebugPanelItem.m
//  qmuidemo
//
//  Created by QMUI Team on 2020/5/20.
//  Copyright © 2020 QMUI Team. All rights reserved.
//

#import "QMUIInteractiveDebugPanelItem.h"

@interface QMUIInteractiveDebugPanelItem ()

@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@end

@interface QMUIInteractiveDebugPanelNumbericItem : QMUIInteractiveDebugPanelItem <QMUITextFieldDelegate>

@property(nonatomic, strong) QMUITextField *textField;
@end

@interface QMUIInteractiveDebugPanelColorItem : QMUIInteractiveDebugPanelNumbericItem
@end

@interface QMUIInteractiveDebugPanelBoolItem : QMUIInteractiveDebugPanelItem

@property(nonatomic, strong) UISwitch *switcher;
@end

@implementation QMUIInteractiveDebugPanelItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleLabel = [[UILabel alloc] qmui_initWithFont:UIFontMake(14) textColor:UIColor.blackColor];
        self.height = 44;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

+ (instancetype)itemWithTitle:(NSString *)title actionView:(__kindof UIView *)actionView valueGetter:(void (^)(__kindof UIView * _Nonnull))valueGetter valueSetter:(void (^)(__kindof UIView * _Nonnull))valueSetter {
    QMUIInteractiveDebugPanelItem *item = QMUIInteractiveDebugPanelItem.new;
    item.title = title;
    item.actionView = actionView;
    item.valueGetter = valueGetter;
    item.valueSetter = valueSetter;
    return item;
}

+ (instancetype)numbericItemWithTitle:(NSString *)title valueGetter:(void (^)(QMUITextField * _Nonnull))valueGetter valueSetter:(void (^)(QMUITextField * _Nonnull))valueSetter {
    QMUIInteractiveDebugPanelNumbericItem *item = QMUIInteractiveDebugPanelNumbericItem.new;
    item.title = title;
    item.actionView = item.textField;
    item.valueGetter = valueGetter;
    item.valueSetter = valueSetter;
    return item;
}

+ (instancetype)colorItemWithTitle:(NSString *)title valueGetter:(void (^)(QMUITextField * _Nonnull))valueGetter valueSetter:(void (^)(QMUITextField * _Nonnull))valueSetter {
    QMUIInteractiveDebugPanelColorItem *item = QMUIInteractiveDebugPanelColorItem.new;
    item.title = title;
    item.actionView = item.textField;
    item.valueGetter = valueGetter;
    item.valueSetter = valueSetter;
    return item;
}

+ (instancetype)boolItemWithTitle:(NSString *)title valueGetter:(void (^)(UISwitch * _Nonnull))valueGetter valueSetter:(void (^)(UISwitch * _Nonnull))valueSetter {
    QMUIInteractiveDebugPanelBoolItem *item = QMUIInteractiveDebugPanelBoolItem.new;
    item.title = title;
    item.actionView = item.switcher;
    item.valueGetter = valueGetter;
    item.valueSetter = valueSetter;
    return item;
}

@end

@implementation QMUIInteractiveDebugPanelNumbericItem

- (QMUITextField *)textField {
    if (!_textField) {
        _textField = [[QMUITextField alloc] qmui_initWithSize:CGSizeMake(160, 38)];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.font = [UIFont fontWithName:@"Menlo" size:14];
        _textField.textColor = UIColor.blackColor;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.qmui_borderWidth = PixelOne;
        _textField.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _textField.qmui_borderColor = [UIColorBlack colorWithAlphaComponent:.3];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(handleTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)handleTextFieldChanged:(QMUITextField *)textField {
    if (!textField.isFirstResponder) return;
    if (self.valueSetter) self.valueSetter(textField);
}

#pragma mark - <QMUITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 删除文字
    if (range.length > 0 && string.length <= 0) {
        return YES;
    }
    
    return !![string qmui_stringMatchedByPattern:@"[-\\d\\.]"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end

@implementation QMUIInteractiveDebugPanelColorItem

- (QMUITextField *)textField {
    QMUITextField *textField = [super textField];
    textField.placeholder = @"255,255,255,1.0";
    return textField;
}

#pragma mark - <QMUITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 删除文字
    if (range.length > 0 && string.length <= 0) {
        return YES;
    }
    
    return !![string qmui_stringMatchedByPattern:@"[\\d\\s\\,\\.]+"];
}

@end

@implementation QMUIInteractiveDebugPanelBoolItem

- (UISwitch *)switcher {
    if (!_switcher) {
        _switcher = [[UISwitch alloc] init];
        _switcher.layer.anchorPoint = CGPointMake(.5, .5);
        _switcher.transform = CGAffineTransformMakeScale(.7, .7);
        [_switcher addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _switcher;
}

- (void)handleSwitchEvent:(UISwitch *)switcher {
    if (self.valueSetter) self.valueSetter(switcher);
}

@end
