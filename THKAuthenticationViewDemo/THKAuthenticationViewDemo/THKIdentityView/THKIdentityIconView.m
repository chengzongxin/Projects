//
//  THKIdentityIconView.m
//  HouseKeeper
//
//  Created by ben.gan on 2020/8/13.
//  Copyright © 2020 binxun. All rights reserved.
//

#import "THKIdentityIconView.h"

#define kAuthorViewSize CGSizeMake(28, 15)
#define kIdentityViewSize CGSizeMake(74, 18)

@interface THKIdentityIconView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation THKIdentityIconView

#pragma mark - Init

- (void)thk_setupViews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.titleLabel];
    [self updateView];

    [self configObserve];
}

- (void)configObserve {
    @weakify(self)
    [RACObserve(self, style) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self updateView];
    }];
}



#pragma mark - Private

- (void)updateView {
    UIImage *image = [self iconImg];
    NSString *title = [self identityTitle];
    
    self.titleLabel.text = title;
    self.iconImgView.image = image;

    self.contentView.layer.cornerRadius = 9;
    self.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;

    CGSize viewSize = [self viewSize];
    
    viewSize.width = [self.titleLabel.text sizeWithFont:self.titleLabel.font width:CGFLOAT_MAX].width + 14 + 4 + 8;

    switch (self.style) {
        case THKIdentityIconViewStyle_Author:
        {
            self.contentView.backgroundColor = THKColor_TextWeakColor;
            self.contentView.layer.cornerRadius = 2;
            self.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
            self.titleLabel.textColor = [UIColor whiteColor];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            viewSize.width = [self.titleLabel.text sizeWithFont:self.titleLabel.font width:CGFLOAT_MAX].width + 8;
        }
            break;
        case THKIdentityIconViewStyle_1:
        {
            self.contentView.backgroundColor = _THKColorWithHexString(@"#FEF6E8");
            self.titleLabel.textColor = _THKColorWithHexString(@"#EB9002");
        }
            break;
        case THKIdentityIconViewStyle_2:
        {
            self.contentView.backgroundColor = [THKColor_MainColor colorWithAlphaComponent:0.1];
            self.titleLabel.textColor = THKColor_MainColor;
        }
            break;
        case THKIdentityIconViewStyle_3:
        case THKIdentityIconViewStyle_4:
        case THKIdentityIconViewStyle_5:
        {
            self.contentView.backgroundColor = _THKColorWithHexString(@"#ECF3FC");
            self.titleLabel.textColor = _THKColorWithHexString(@"#3380D9");
        }
            break;
        default:
            viewSize.width = 0;
            break;
    }
    
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.size.mas_equalTo(viewSize);
    }];
    [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(image ? CGSizeMake(14, 14) : CGSizeZero);
        make.left.top.equalTo(@(2));
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.style == THKIdentityIconViewStyle_Author) {
            make.center.equalTo(self.contentView);
        } else {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconImgView.mas_right).offset(2);
            make.right.equalTo(@(-8));
        }
    }];
    
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImage *)iconImg {
    switch (self.style) {
        case THKIdentityIconViewStyle_1:
            return kImgAtBundle(@"icon_identity_orange");
        case THKIdentityIconViewStyle_2:
            return kImgAtBundle(@"icon_identity_green");
        case THKIdentityIconViewStyle_3:
            return kImgAtBundle(@"icon_identity_yellow");
        case THKIdentityIconViewStyle_4:
            return kImgAtBundle(@"icon_identity_yellow");
        case THKIdentityIconViewStyle_5:
            return kImgAtBundle(@"icon_identity_yellow");
        default:
            break;
    }
    return nil;
}

- (NSString *)identityTitle {
    switch (self.style) {
        case THKIdentityIconViewStyle_Author:
            return @"作者";
        case THKIdentityIconViewStyle_1:
            return @"家居达人";
        case THKIdentityIconViewStyle_2:
            return @"官方认证";
        case THKIdentityIconViewStyle_3:
            return @"设计机构";
        case THKIdentityIconViewStyle_4:
            return @"品牌商家";
        case THKIdentityIconViewStyle_5:
            return @"装修公司";
        default:
            break;
    }
    return nil;
}

- (CGSize)viewSize {
    switch (self.style) {
        case THKIdentityIconViewStyle_Author:
            return kAuthorViewSize;
        case THKIdentityIconViewStyle_None:
            return CGSizeZero;
        default:
            return kIdentityViewSize;
    }
    return CGSizeZero;
}

@end
