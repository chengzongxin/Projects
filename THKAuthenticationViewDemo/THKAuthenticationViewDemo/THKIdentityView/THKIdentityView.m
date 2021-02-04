//
//  THKAuthenticationView.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/1/19.
//

//typedef NS_ENUM(NSInteger, THKIdentityViewStyle) {
//    THKIdentityViewStyle_None,      //无
//    THKIdentityViewStyle_Author,    //作者
//    THKIdentityViewStyle_1,         //家居达人
//    THKIdentityViewStyle_2,         //官方认证
//    THKIdentityViewStyle_3,         //设计机构
//    THKIdentityViewStyle_4,         //品牌商家
//    THKIdentityViewStyle_5,         //装修公司
//};


#import "THKIdentityView.h"
#import <YYKit.h>
#import <Masonry.h>


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
@property (nonatomic, assign) THKIdentityViewStyle style;
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

- (instancetype)initWithType:(NSInteger)type subType:(NSInteger)subType style:(THKIdentityViewStyle)style{
    self = [super init]; // 调用 initWithFrame
    if (!self) return nil;
    
    _type = type;
    _subType = subType;
    _style = style;
    
    [self updateUI];
    
    return self;
}

- (instancetype)init {
    NSAssert(0, @"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." );
//    @throw [NSException exceptionWithName:@"THKIdentityView init error" reason:@"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." userInfo:nil];
    return [self initWithType:0 style:THKIdentityViewStyle_Icon];
}


- (void)setupSubviews{
    
    if (self.style == THKIdentityViewStyle_Full) {
        // 显示全部
        self.backgroundColor = self.config.backgroundColor;
        self.layer.cornerRadius = (self.config.iconSize.height + kImageMargin * 2)/2;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.textLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).inset(kImageMargin + self.iconOffset.x);
            make.centerY.equalTo(self.mas_centerY).offset(self.iconOffset.y);
            make.size.mas_equalTo(self.config.iconSize);
        }];
        
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(kImageTextInterval);
            make.right.equalTo(self).inset(kImageMargin).priorityHigh();
            make.centerY.equalTo(self.iconImageView.mas_centerY);
        }];
        
    }else{
        // 显示icon
        [self addSubview:self.iconImageView];
        
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.superview).offset(self.iconOffset.y);
//            make.right.equalTo(self.superview).offset(self.iconOffset.x);
//        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
}

#pragma mark - Private
///  完整显示文字时，需要做Size计算处理自适应宽度
- (CGSize)intrinsicContentSize{
    // 只有图标的时候,直接返回icon尺寸
    
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

- (void)updateUI{
    
    _config = [THKIdentityConfiguration configWithIdentityType:_type subType:_subType];
    
    [self setupSubviews];
}

#pragma mark - Getter && Setter

- (void)setType:(NSInteger)type{
    [self setType:type subType:0];
}

- (void)setType:(NSInteger)type subType:(NSInteger)subType{
    _type = type;
    _subType = subType;
    
    _config = [THKIdentityConfiguration configWithIdentityType:_type subType:_subType];
    
    if (_style == THKIdentityViewStyle_Full) {
        
        self.backgroundColor = self.config.backgroundColor;
        self.layer.cornerRadius = (self.config.iconSize.height + kImageMargin * 2)/2;
        // 一开始是Icon,后来改成Full形式，需要添加
        if (!self.textLabel.superview) {
            [self addSubview:self.textLabel];
        }
        
        _textLabel.text = self.config.text;
        _textLabel.textColor = self.config.textColor;
        _textLabel.font = self.config.font;
//        [_iconImageView loadImageWithUrlStr:self.config.iconUrl placeHolderImage:self.config.iconLocal];
        [_iconImageView setImageWithURL:[NSURL URLWithString:self.config.iconUrl] placeholder:self.config.iconLocal];
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
//        [_iconImageView loadImageWithUrlStr:self.config.iconUrl placeHolderImage:self.config.iconLocal];
        [_iconImageView setImageWithURL:[NSURL URLWithString:self.config.iconUrl] placeholder:self.config.iconLocal];
        
        [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    
    // 重新计算内置size
    [self invalidateIntrinsicContentSize];
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
        _iconImageView.layer.cornerRadius = self.style == THKIdentityViewStyle_Full ? self.config.iconSize.height/2 : 0;
        _iconImageView.layer.masksToBounds = YES;
        if (self.config.iconUrl) {
//            [_iconImageView loadImageWithUrlStr:self.config.iconUrl placeHolderImage:self.config.iconLocal];
            [_iconImageView setImageWithURL:[NSURL URLWithString:self.config.iconUrl] placeholder:self.config.iconLocal];
        }else{
            _iconImageView.image = self.config.iconLocal;
        }
    }
    return _iconImageView;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = self.config.text;
        _textLabel.textColor = self.config.textColor;
        _textLabel.font = self.config.font;
    }
    return _textLabel;
}


@end
