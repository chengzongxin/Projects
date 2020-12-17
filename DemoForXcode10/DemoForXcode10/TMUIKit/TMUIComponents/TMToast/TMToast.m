//
//  TMToast.m
//  Masonry
//
//  Created by nigel.ning on 2020/4/28.
//

#import "TMToast.h"
#import <Masonry/Masonry.h>
#import "TMUICommonDefines.h"
#import "TMUIKitDefines.h"
#import "UIColor+TMUI.h"

@interface TMToastView : UIView
@property (nonatomic, strong)UIVisualEffectView *effectView;
@property (nonatomic, strong)UILabel *msgLbl;
@property (nonatomic, copy)void(^_Nullable hideFinishBlock)(void);
@property (nonatomic, assign)NSTimeInterval duration;
@end

@implementation TMToastView

+ (instancetype)toastViewWithString:(NSString *)str {
    TMToastView *view = [[self alloc] init];
    view.msgLbl.text = str;
    view.duration = [TMToast duration];
    return view;
}

+ (instancetype)toastViewWithAttributedString:(NSAttributedString *)attriStr {
    TMToastView *view = [[self alloc] init];
    view.msgLbl.attributedText = attriStr;
    view.duration = [TMToast duration];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    //self.backgroundColor = [[UIColor tmui_colorWithHexString:@"353535"] colorWithAlphaComponent:0.5];
    self.layer.zPosition = FLT_MAX;//保证始终显示在最上层
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:self.effectView];
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.msgLbl = [[UILabel alloc] init];
    [self.effectView.contentView addSubview:self.msgLbl];
    [self.msgLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.trailing.mas_equalTo(-16);
        make.centerY.mas_equalTo(self.effectView.contentView.mas_centerY);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    self.msgLbl.textColor = [UIColor whiteColor];
    self.msgLbl.font = UIFont(12);
    self.msgLbl.numberOfLines = 0;
    self.msgLbl.textAlignment = NSTextAlignmentCenter;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window || window.isHidden) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    [window addSubview:self];
    self.alpha = 0;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 17;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_greaterThanOrEqualTo(50);
        make.trailing.mas_lessThanOrEqualTo(-50);
        make.height.mas_greaterThanOrEqualTo(34);
        make.centerX.mas_equalTo(window.mas_centerX);
        make.top.mas_equalTo(tmui_safeAreaTopInset() + 44);
    }];
    [self.superview setNeedsUpdateConstraints];
    [self.superview updateConstraints];
    [self.superview layoutSubviews];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tmui_safeAreaTopInset() + 44 + 54);
        }];
        [self.superview setNeedsUpdateConstraints];
        [self.superview updateConstraints];
        [self.superview layoutSubviews];
    } completion:^(BOOL finished) {
        [self delayHide];
    }];
}

- (void)delayHide {
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration > 0 ? self.duration : [TMToast duration]];
}

- (void)dismiss {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.hideFinishBlock) {
            self.hideFinishBlock();
        }
    }];
}

@end


@interface TMToast()

@end

@implementation TMToast

static NSTimeInterval s_duration = 1.0;
+ (NSTimeInterval)duration {
    return s_duration;
}

+ (void)setDuration:(NSTimeInterval)duration {
    s_duration = duration;
}

+ (void)toast:(NSString *)str {
    [self toast:str hideAfterDelay:[self duration] hideFinishBlock:nil];
}

+ (void)toastAttributedString:(NSAttributedString *)attrStr {
    [self toastAttributedString:attrStr hideAfterDelay:[self duration] hideFinishBlock:nil];
}

#pragma mark - 针对一些特殊场景需要自定义显示的时长及消失后的回调提供支持

+ (void)toast:(NSString *)str hideAfterDelay:(NSTimeInterval)delay hideFinishBlock:(void(^_Nullable)(void))block {
    if (!str) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'str' must not be nil.");
                )
        return;
    }
    
    if (![str isKindOfClass:[NSString class]]) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'str' must be a string.");
                )
        return;
    }
    
    if (str.length == 0) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'str' must not be empty.");
                )
        return;
    }
    
    TMToastView *view = [TMToastView toastViewWithString:str];
    view.duration = delay;
    view.hideFinishBlock = block;
    [view show];
}

+ (void)toastAttributedString:(NSAttributedString *)attrStr hideAfterDelay:(NSTimeInterval)delay hideFinishBlock:(void(^_Nullable)(void))block {
    if (!attrStr) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'attrStr' must not be nil.");
                )
        return;
    }
    
    if (![attrStr isKindOfClass:[NSAttributedString class]]) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'attrStr' must be a attributedString.");
                )
        return;
    }
    
    if (attrStr.length == 0) {
TMUI_DEBUG_Code(
                NSLog(@"toast 'attrStr' must not be empty.");
                )
        return;
    }
    
    TMToastView *view = [TMToastView toastViewWithAttributedString:attrStr];
    view.duration = delay;
    view.hideFinishBlock = block;
    [view show];
}

@end


@implementation TMToast(ScoreToast)

+ (void)toastScore:(NSInteger)score content:(NSString *)content {
    
    if (content.length == 0) {
        return;
    }
    
    UIImage *icon = [UIImage imageNamed:@"TMToastAssets.bundle/icon_gold_coin"];
    NSAssert(icon, @"score icon should not be nil");
    
    if (!icon ||
        score <= 0) {
        //当icon读取失败时  或
        //score <= 0时
        //按普通toast处理
        if (content.length > 0) {
            [self toast:content];
        }
    }else {
        //score>0 && content有值时才显示指定样式的toast
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:@""];
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = icon;
        attachment.bounds = CGRectMake(0, -4, 16, 16);
        [mAttr appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        
        if (content.length > 0) {
            NSAttributedString *contentStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", content] attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: UIFont(12)}];
            [mAttr appendAttributedString:contentStr];
        }
        
        NSMutableAttributedString *rightTxtStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" +%ld兔币", score] attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: UIFont(12)}].mutableCopy;
        //微调+号的显示位置，默认位置太靠下了，上移一点
        //NSRange addSymbolRange = [rightTxtStr.string rangeOfString:@"+"];
        //[rightTxtStr addAttribute:NSBaselineOffsetAttributeName value:@(2) range:addSymbolRange];
        [mAttr appendAttributedString:rightTxtStr];
        
        [mAttr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, mAttr.length)];
        
        [self toastAttributedString:mAttr];
    }
}

@end
