//
//  THKUserCenterHeaderViewModel.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/1.
//

#import "THKUserCenterHeaderViewModel.h"

@interface THKUserCenterHeaderViewModel ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *tagName;
@property (nonatomic, strong, readwrite) NSString *signature;
@property (nonatomic, strong, readwrite) THKUserSocialViewModel *socailViewModel;

@end

@implementation THKUserCenterHeaderViewModel

- (void)initialize{
    _bgImageH = 180;
    _avatarTop = 150;
    _avatarH = 72;
    _nameTop = 16;
    _nameH = 30;
    _tagTop = 9;
    _tagH = 24;
    _signatureTop = 12;
    _signatureH = 17;
    _socialTop = 12;
    _socialH = 20;
    _storeTop = 16;
    _storeH = 20;
    _ecologicalTop = 23;
    _ecologicalH = 60;
    _serviceTop = 30;
    _serviceH = 237;
    
    [self bindWithModel:@""];
}

// 更新数据和约束
- (void)bindWithModel:(id)model{
    
    self.name = @"装修界的电动小马达";
    self.tagName = @"设计机构";
    self.signature =  @"123个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名，个性签名";
    
    THKUserSocialViewModel *socialVM = [[THKUserSocialViewModel alloc] init];
    socialVM.followCount = 2432;
    socialVM.fansCount = 2332;
    socialVM.beThumbupAndColloctCount = 111134;
    self.socailViewModel = socialVM;
    
    // 更新高度约束
    if (self.signature.length > 0) {
        _signatureH = [self widthForString:self.signature font:UIFont(12)];
    }else{
        _signatureTop = 0;
        _signatureH = 0;
    }
    // 店铺
    BOOL showStore = YES;
    if (showStore) {
        _storeTop = 16;
        _storeH = 20;
    }else{
        _storeTop = 0;
        _storeH = 0;
    }
    
    // 生态大会
    BOOL showEcologic = YES;
    if (showEcologic) {
        _ecologicalTop = 23;
        _ecologicalH = 60;
    }else{
        _ecologicalTop = 0;
        _ecologicalH = 0;
    }
    
    // 服务信息
    BOOL showService = YES;
    if (showService) {
        _serviceTop = 30;
        _serviceH = 237;
    }else{
        _serviceTop = 0;
        _serviceH = 0;
    }
    
    
    [super bindWithModel:model];
}


#pragma mark Public Method

- (CGFloat)viewHeight{
    CGFloat height = 0;
    height += _avatarTop;
    height += _avatarH;
    height += _nameTop;
    height += _nameH;
    height += _tagTop;
    height += _tagH;
    height += _signatureTop;
    height += _signatureH;
    height += _socialTop;
    height += _socialH;
    height += _storeTop;
    height += _storeH;
    height += _ecologicalTop;
    height += _ecologicalH;
    height += _serviceTop;
    height += _serviceH;
    return height;
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
