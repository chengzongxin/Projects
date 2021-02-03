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
    self = [super init]; // 调用 initWithFrame
    if (!self) return nil;
    
    self.type = type;
    self.style = style;
    self.config = [THKIdentityConfiguration configWithIdentityType:self.type];
    
    return self;
}

- (instancetype)init {
    NSAssert(0, @"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." );
//    @throw [NSException exceptionWithName:@"THKIdentityView init error" reason:@"THKIdentityView must be initialized with a type. Use 'initWithType:' instead." userInfo:nil];
    return [self initWithType:0 style:THKIdentityViewStyle_Icon];
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = 0;
        self.style = THKIdentityViewStyle_Icon;
        self.config = [THKIdentityConfiguration configWithIdentityType:self.type];
    }
    return self;
}


- (void)didMoveToSuperview{
    if (!self.superview) {
        return;
    }
    
    [self setupSubviews];
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
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview).offset(self.iconOffset.y);
            make.right.equalTo(self.superview).offset(self.iconOffset.x);
        }];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(self.config.iconSize);
        }];
    }
}

#pragma mark - Private
///  完整显示文字时，需要做Size计算处理自适应宽度
- (CGSize)intrinsicContentSize{
    // 只有图标的时候,直接返回icon尺寸
    
    if (!self.config.icon) {
        return CGSizeZero;
    }
    
    if (self.style == THKIdentityViewStyle_Icon) {
        return self.config.iconSize;
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

- (CGSize)viewSize{
    if (self.superview) {
        return self.intrinsicContentSize;
    }else{
        return CGSizeZero;
    }
}

- (void)setType:(NSInteger)type{
    _type = type;
    
    [self invalidateIntrinsicContentSize];
}

- (void)setStyle:(THKIdentityViewStyle)style{
    _style = style;
    
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
        self.tapBlock(self.type);
    }
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:self.config.icon];
        _iconImageView.layer.cornerRadius = self.config.iconSize.height/2;
        _iconImageView.layer.masksToBounds = YES;
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
