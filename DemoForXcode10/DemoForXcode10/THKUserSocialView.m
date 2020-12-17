//
//  THKUserSocialView.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import "THKUserSocialView.h"
#import "TMContentAlert.h"
#import "BeCollectThumbupView.h"
#import "UIViewController+Convenient.h"
#import "UIButton+Convenient.h"

@interface THKUserSocialView ()

@property (nonatomic, strong, readonly) THKUserSocialViewModel *viewModel;

@end

@implementation THKUserSocialView
TMUI_PropertySyntheSize(viewModel);

- (void)thk_setupViews {
    [self addSubview:self.followCountButton];
    [self addSubview:self.fansCountButton];
    [self addSubview:self.beCollectCountButton];
    
    
    [self.followCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(60);
    }];
    
    [self.fansCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.followCountButton.mas_right).offset(20);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(60);
    }];
    
    [self.beCollectCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fansCountButton.mas_right).offset(20);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(60);
    }];
}

- (void)clickFollowCountButton{
    NSLog(@"%s",__func__);
}

- (void)clickFansCountButton{
    NSLog(@"%s",__func__);
}

- (void)bindViewModel:(THKUserSocialViewModel *)viewModel{
    [super bindViewModel:viewModel];
    NSAttributedString *followAttrText = [self attrWithText:@"关注" number:viewModel.followCount];
    NSAttributedString *fansAttrText = [self attrWithText:@"粉丝" number:viewModel.fansCount];
    NSAttributedString *befollowAttrText = [self attrWithText:@"获赞与收藏" number:viewModel.beThumbupAndColloctCount];
    CGFloat followCountW = [self widthForAttributeString:followAttrText];
    CGFloat fansCountW = [self widthForAttributeString:fansAttrText];
    CGFloat beFollowCountW = [self widthForAttributeString:befollowAttrText];
    
    self.followCountButton.attrText = followAttrText;
    self.fansCountButton.attrText = fansAttrText;
    self.beCollectCountButton.attrText = befollowAttrText;
    
    // 关注
    [self.followCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(followCountW);
    }];
    // 粉丝
    [self.fansCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(fansCountW);
    }];
    // 被点赞收藏
    [self.beCollectCountButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(beFollowCountW);
    }];
}


- (void)clickBeCollect{
    BeCollectThumbupView *alert = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BeCollectThumbupView.class) owner:self options:nil].lastObject;
    
    [TMContentAlert showFromViewController:[UIViewController getCurrentVC] loadContentView:^(__kindof UIViewController * _Nonnull toShowVc) {
        [toShowVc.view addSubview:alert];
        alert.frame = toShowVc.view.bounds;
        alert.alpha = 0;
    } didShowBlock:^{
        //alpha渐变显示
        [UIView animateWithDuration:0.15 animations:^{
            alert.alpha = 1;
        }];
    }];
}


- (UIButton *)followCountButton{
    if (!_followCountButton) {
        _followCountButton = [[UIButton alloc] init];
        [_followCountButton addTarget:self action:@selector(clickFollowCountButton)];
    }
    return _followCountButton;
}

- (UIButton *)fansCountButton{
    if (!_fansCountButton) {
        _fansCountButton = [[UIButton alloc] init];
        [_fansCountButton addTarget:self action:@selector(clickFansCountButton)];
    }
    return _fansCountButton;
}

- (UIButton *)beCollectCountButton{
    if (!_beCollectCountButton) {
        _beCollectCountButton = [[UIButton alloc] init];
        [_beCollectCountButton addTarget:self action:@selector(clickBeCollect)];
    }
    return _beCollectCountButton;
}


#pragma mark Private
- (NSAttributedString *)attrWithText:(NSString *)text number:(NSInteger)number{
    NSString *allStr = [NSString stringWithFormat:@"%@ %ld",text,(long)number];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allStr attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16],NSForegroundColorAttributeName:UIColorHexString(@"111111")}];
    NSRange range = [allStr rangeOfString:text];
    [string addAttributes:@{NSFontAttributeName:UIFont(12),NSForegroundColorAttributeName:UIColorHexString(@"#878B99")} range:range];
    
    return string;
}

- (CGFloat)widthForString:(NSString *)string font:(UIFont *)font{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 3;
    NSDictionary *attrs = @{NSParagraphStyleAttributeName:style,
                            NSFontAttributeName:font
    };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return ceilf([attrStr boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 16*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height);
}

- (CGFloat)widthForAttributeString:(NSAttributedString *)attrStr{
    return ceilf([attrStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width);
}


@end
