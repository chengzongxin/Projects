//
//  THKAuthenticationView.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/1/19.
//


#import "THKIdentityView.h"
#import "UIImageView+TCategory.h"
#import "THKIdentityConfigManager.h"


static CGFloat const kImageMargin = 4;
static CGFloat const kImageTextInterval = 4;


@interface THKIdentityView ()
/// 标识View配置对象
@property (nonatomic, strong) THKIdentityConfiguration *config;
/// 标识类型
@property (nonatomic, assign) NSInteger type;
/// 标识类型
@property (nonatomic, assign) NSInteger subType;
/// 标识样式
//@property (nonatomic, assign) THKIdentityViewStyle style;
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
/// 文本
@property (nonatomic, strong) UILabel *textLabel;

@end




@implementation THKIdentityView

#pragma mark - Life Cycle
- (void)dealloc{
    NSLog(@"THKIdentityView dealloc");
}

#pragma mark - Public
+ (instancetype)identityView{
    return [self identityViewWithType:0];
}

+ (instancetype)identityViewWithType:(NSInteger)type{
    return [self identityViewWithType:type style:THKIdentityViewStyle_Icon];
}

+ (instancetype)identityViewWithType:(NSInteger)type style:(THKIdentityViewStyle)style{
    return [[self alloc] initWithType:type style:style];
}

- (instancetype)initWithType:(NSInteger)type style:(THKIdentityViewStyle)style{
    return [self initWithType:type subType:0 style:style];
}

/// init 创建
/// @param type 标识类型
/// @param subType 二级类型
/// @param style 样式
- (instancetype)initWithType:(NSInteger)type subType:(NSInteger)subType style:(THKIdentityViewStyle)style{
    self = [super init]; // 调用 initWithFrame
    if (!self) return nil;
    
    _type = type;
    _subType = subType;
    _style = style;
    
    [self reloadData];
    
    return self;
}

- (instancetype)init {
//    NSAssert(0, @"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." );
//    @throw [NSException exceptionWithName:@"THKIdentityView init error" reason:@"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." userInfo:nil];
    return [self initWithType:0 style:THKIdentityViewStyle_Icon];
}

/// xib创建
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (!self) return nil;
    
    _type = 0;
    _subType = 0;
    
    [self reloadData];
    
    return self;
}

// MARK: 刷新数据和UI，初始化，xib，重新设置Type时调用
- (void)reloadData{
    _config = [THKIdentityConfigManager.shareInstane fetchConfigWithType:_type subType:_subType];
    
    [self invalidateIntrinsicContentSize];
    
    if (_config) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
        return;
    }
    
    [self updateData];
    
    [self updateUI];
}

- (void)updateData{
    if (self.config.iconUrl) {
        [self.iconImageView loadImageWithUrlStr:self.config.iconUrl placeHolderImage:self.config.iconLocal];
    }else{
        self.iconImageView.image = self.config.iconLocal;
    }
    
    if (_style == THKIdentityViewStyle_Full) {
        self.textLabel.text = self.config.text;
        self.textLabel.textColor = self.config.textColor;
        self.textLabel.font = self.config.font;
    }
}

- (void)updateUI{
    if (!self.iconImageView.superview) {
        [self addSubview:self.iconImageView];
    }
    
    if (_style == THKIdentityViewStyle_Full) {
        
        self.backgroundColor = self.config.backgroundColor;
        self.layer.cornerRadius = (self.config.iconSize.height + kImageMargin * 2)/2;
        // 一开始是Icon,后来改成Full形式，需要添加
        if (!self.textLabel.superview) {
            [self addSubview:self.textLabel];
        }
        
        
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).inset(kImageMargin + self.iconOffset.x);
            make.centerY.equalTo(self.mas_centerY).offset(self.iconOffset.y);
            make.size.mas_equalTo(self.config.iconSize);
        }];
        
        
        [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(kImageTextInterval);
            make.right.equalTo(self).inset(kImageMargin).priorityHigh();
            make.centerY.equalTo(self.iconImageView.mas_centerY);
        }];
        
    }else{
        
        self.backgroundColor = UIColor.clearColor;
        self.layer.cornerRadius = 0;
        
        if (_textLabel) {
            [_textLabel removeFromSuperview];
            _textLabel = nil;
        }
        
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
}

#pragma mark - Private
///  完整显示文字时，需要做Size计算处理自适应宽度
- (CGSize)intrinsicContentSize{
    // 只有图标的时候,直接返回icon尺寸
    if (_type <= 0) {
        return CGSizeZero;
    }
    
    if (!self.config.iconLocal && !self.config.iconUrl) {
        return CGSizeZero;
    }
    
    if (self.style == THKIdentityViewStyle_Icon) {
        return self.frame.size;
    }
    
    // 完整显示的时候，计算图标和文本宽高
    CGFloat iconH = self.config.iconSize.height;
    CGSize size = CGSizeMake(0, iconH + kImageMargin * 2);
    
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT);
    //计算文本尺寸
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:maxSize text:_textLabel.attributedText];
    CGFloat textW = layout.textBoundingSize.width;
    CGFloat iconW = size.height - kImageMargin * 2;
    size.width = kImageMargin + iconW + kImageTextInterval + textW + kImageMargin;
    
    return size;
}

#pragma mark - Getter && Setter

- (void)setType:(NSInteger)type{
    [self setType:type subType:0];
}

- (void)setType:(NSInteger)type subType:(NSInteger)subType{
    _type = type;
    _subType = subType;
    
    [self reloadData];
}


- (void)setIconOffset:(CGPoint)iconOffset{
    _iconOffset = iconOffset;
    
    if (self.iconImageView.superview && self.superview) {
        if (self.style == THKIdentityViewStyle_Full) {
            [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).inset(kImageMargin + self.iconOffset.x);
                make.centerY.equalTo(self.mas_centerY).offset(self.iconOffset.y);
            }];
        }else{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.superview).offset(self.iconOffset.y);
                make.right.equalTo(self.superview).offset(self.iconOffset.x);
            }];
        }
    }
}

- (void)setTapBlock:(THKIdentityViewTapBlock)tapBlock{
    _tapBlock = tapBlock;
    
    if (tapBlock) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tapAction{
    if (self.tapBlock) {
        self.tapBlock(_type);
    }
}


- (CGSize)viewSize{
    [self layoutIfNeeded];
    
    if (self.width*self.height > self.intrinsicContentSize.width*self.intrinsicContentSize.height) {
        return self.size;
    }else{
        return self.intrinsicContentSize;
    }
}


- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
    }
    return _textLabel;
}


@end
