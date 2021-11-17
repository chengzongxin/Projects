//
//  TMSearchBar.m
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/6.
//  Copyright © 2020 t8t. All rights reserved.
//

#import "TMSearchBar.h"
#import <Masonry/Masonry.h>
#import "TMUICommonDefines.h"
#import "TMUIExtensions.h"
#import "TMUIKitDefines.h"

#pragma mark -
#pragma mark - TMSearchBarCancelButton
@interface TMSearchBarCancelButton : UIButton
@end

@implementation TMSearchBarCancelButton
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width = self.titleLabel.intrinsicContentSize.width;
    size.width = MAX(30, size.width);
    return size;
}
@end

#pragma mark -
#pragma mark - TMSearchBarInnerTextField
@interface TMSearchBarInnerTextField : UITextField
@property (nonatomic, assign)float leftViewWidth;///< 当左侧视图有值时有效。左侧视图展示时的宽度，需要外部赋值，若外部不赋值则取默认值20
@end

@implementation TMSearchBarInnerTextField
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rt = [super leftViewRectForBounds:bounds];
    if (!self.leftView) {
        return rt;
    }
    
    rt.size.height = MIN(rt.size.height, bounds.size.height);
    rt.size.width = MIN(rt.size.width, bounds.size.width);
    
    if (self.leftViewWidth == 0.0) {
        rt.size.width = MIN(20, rt.size.width);
    }else {
        rt.size.width = MIN(self.leftViewWidth, rt.size.width);
    }
    
    return rt;
}
@end

#pragma mark -
#pragma mark - TMSearchBar
@interface TMSearchBar()<UITextFieldDelegate>
@property (nonatomic, strong)TMSearchBarCancelButton *cancelBtn;
@property (nonatomic, strong)TMSearchBarInnerTextField *textField;
@property (nonatomic, strong)UIView *bottomLineView;
@end

@implementation TMSearchBar
@synthesize backgroundImageView = _backgroundImageView;
@synthesize textField = _textField;
@synthesize text = _text;

TMUI_DEBUG_Code_Dealloc_Other(
    [[NSNotificationCenter defaultCenter] removeObserver:self];
                              )


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self initConfigs];
    
    _backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:_backgroundImageView];
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    _textField = [[TMSearchBarInnerTextField alloc] init];
    _textField.clipsToBounds = YES;
    _textField.backgroundColor = UIColorRGB(235.0f, 235.0f, 236.0f);
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_leading).mas_offset(self.contentEdgeInsets.left);
        make.top.mas_equalTo(self.mas_top).mas_offset(self.contentEdgeInsets.top);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-self.contentEdgeInsets.bottom);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-self.contentEdgeInsets.right);
    }];
    _textField.delegate = self;
    [self configTextField];
    
    self.cancelBtn = [[TMSearchBarCancelButton alloc] init];
    [self.cancelBtn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = self.cancelButtonFont;
    [self.cancelBtn setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mas_trailing);
        make.top.mas_equalTo(_textField.mas_top);
        make.bottom.mas_equalTo(_textField.mas_bottom);
    }];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.clipsToBounds = YES;
    self.bottomLineView.backgroundColor = UIColorRGB(228.0f, 228.0f, 229.0f);
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TMSearchBarTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initConfigs {
    _contentEdgeInsets = UIEdgeInsetsMake(8, 12, 8, 12);
    _font = [UIFont systemFontOfSize:12];
    _textColor = [UIColor blackColor];
    
    _cancelButtonTitle = @"取消";
    _cancelButtonFont = [UIFont systemFontOfSize:12];
    _cancelButtonTitleColor = [UIColor blackColor];
}

- (UIImage *)searchBarIcon {
    UIImage *icon = [UIImage imageNamed:@"TMSearchUIAssets.bundle/searchBarLeftIcon"];
    return icon;
}

- (void)configTextField {
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    UIImage *searchIcon = [self searchBarIcon];
    float searchIconSize = MIN(ceil(searchIcon.size.width), 20);//icon尺寸最多不能超过20x20,超出则统一按20x20显示效果处理
    float searchIconGap = 4;
    //手动指定leftView默认的宽度为searchIcon + gap * 2, 注意：需要给_textField.leftViewWidth赋值才算有效
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchIconSize + searchIconGap * 2, searchIconSize + searchIconGap * 2)];
    leftView.clipsToBounds = YES;
    UIImageView *searchIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(searchIconGap, searchIconGap, searchIconSize, searchIconSize)];
    [leftView addSubview:searchIconImgView];
    [searchIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(leftView);
        make.width.height.mas_equalTo(searchIconSize);
    }];    
    searchIconImgView.clipsToBounds = YES;
    searchIconImgView.image = searchIcon;
    searchIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    _textField.leftViewWidth = searchIconSize + searchIconGap * 2;
    _textField.leftView = leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - event callback
- (void)TMSearchBarTextDidChange:(NSNotification *)noti {
    UITextField *tf = noti.object;
    if ([tf isEqual:self.textField]) {
        UITextRange *selectedRange = [_textField markedTextRange];
        UITextPosition *position = [_textField positionFromPosition:selectedRange.start offset:0];
        if (position) {
            //处于拼音输入且还未确认汉字的状态，忽略此输入过程中的临时变化
            return;
        }
        if ([self.delegate respondsToSelector:@selector(tmSearchBar:textDidChange:)]) {
            [self.delegate tmSearchBar:self textDidChange:tf.text];
        }
    }
}

- (void)cancelBtnClick {
    if ([self.delegate respondsToSelector:@selector(tmSearchBarCancelButtonClicked:)]) {
        [self.delegate tmSearchBarCancelButtonClicked:self];
    }
}

#pragma mark - setters & getters
- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    _contentEdgeInsets = contentEdgeInsets;
    
    if ([self isActive]) {
        CGSize cancelBtnSize = [self.cancelBtn intrinsicContentSize];
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-self.contentEdgeInsets.right - 12 - cancelBtnSize.width);
            make.top.mas_equalTo(self.mas_top).mas_offset(self.contentEdgeInsets.top);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-self.contentEdgeInsets.bottom);
        }];
        [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_trailing).mas_offset(-self.contentEdgeInsets.right - cancelBtnSize.width);
        }];
    }else {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-self.contentEdgeInsets.right);
            make.top.mas_equalTo(self.mas_top).mas_offset(self.contentEdgeInsets.top);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-self.contentEdgeInsets.bottom);
        }];
        [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_trailing);
        }];
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
    [self layoutIfNeeded];
}

- (void)setText:(NSString *)text {
    _text = text;

    //_textField.text = text;// setText不会触发textDidChange的通知回调，这里调整一下手动赋值修改的处理逻辑以便可以正常触发textDidChange的通知
    _textField.text = @"";
    [_textField insertText:text ?: @""];//此方法会触发相关通知回调    
}

- (NSString *)text {
    _text = _textField.text;
    return _text;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _textField.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textField.textColor = textColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self updatePlaceholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self updatePlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updatePlaceholder];
}

- (void)updatePlaceholder {
    if (self.placeholder.length > 0) {
        NSMutableAttributedString *mAttri = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderColor ?: [[UIColor grayColor] colorWithAlphaComponent:0.7], NSFontAttributeName: self.placeholderFont ?: self.font}];
        _textField.attributedPlaceholder = mAttri;
    }else {
        _textField.placeholder = nil;
    }
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = cancelButtonTitle;
    [self.cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)setCancelButtonFont:(UIFont *)cancelButtonFont {
    _cancelButtonFont = cancelButtonFont;
    self.cancelBtn.titleLabel.font = cancelButtonFont;
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    _cancelButtonTitleColor = cancelButtonTitleColor;
    [self.cancelBtn setTitleColor:cancelButtonTitleColor forState:UIControlStateNormal];
}

- (void)setActive:(BOOL)active {
    [self setActive:active animate:NO];
}
- (void)setActive:(BOOL)active animate:(BOOL)animate {
    _active = active;
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentEdgeInsets = self.contentEdgeInsets;
        }];
    }else {
        self.contentEdgeInsets = self.contentEdgeInsets;
    }
}

- (void)setBottomLineHide:(BOOL)bottomLineHide {
    _bottomLineHide = bottomLineHide;
    self.bottomLineView.hidden = bottomLineHide;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    self.bottomLineView.backgroundColor = bottomLineColor;
}

#pragma mark - firstResponder
- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textField becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    return [self.textField resignFirstResponder];
}
- (BOOL)isFirstResponder {
    return [self.textField isFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(tmSearchBarTextShouldBeginEditing:)]) {
        return [self.delegate tmSearchBarTextShouldBeginEditing:self];
    }
    //default return YES;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(tmSearchBarTextDidBeginEditing:)]) {
        [self.delegate tmSearchBarTextDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {return YES;}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(tmSearchBarSearchButtonClicked:)]) {
        [self.delegate tmSearchBarSearchButtonClicked:self];
    }
    return YES;
}

@end
