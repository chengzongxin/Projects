//
//  THKUserCenterHeaderView.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/1.
//

#import "THKUserCenterHeaderView.h"
#import "THKUserSocialView.h"
#import "UIButton+Convenient.h"
#import "THKShowBigImageViewController.h"
#import "CALayer+YYAdd.h"
#import "UIView+YYAdd.h"
#import "CALayer+Shadow.h"
#import "UIImage+THKCorner.h"
#import "THKShadowImageView.h"

@interface THKUserCenterHeaderView ()

@property (nonatomic, strong, readwrite) THKUserCenterHeaderViewModel *viewModel;
/// 背景主图
@property (nonatomic, strong) UIImageView *bgImageView;
/// 圆角视图
@property (nonatomic, strong) UIView *cornerView;
/// 头像
@property (nonatomic, strong) THKShadowImageView *avatarImageView;
/// 名字
@property (nonatomic, strong) UILabel *nameLabel;
/// 设计机构
@property (nonatomic, strong) UIButton *tagButton;
/// 问号提示
@property (nonatomic, strong) UIButton *tipsButton;
/// 关注按钮
@property (nonatomic, strong) UIButton *followButton;
/// 用户签名
@property (nonatomic, strong) UILabel *signatureLabel;
/// 用户社交组件
@property (nonatomic, strong) THKUserSocialView *socialView;
/// TA的店铺
@property (nonatomic, strong) UIButton *storeButton;
/// 生态大会
@property (nonatomic, strong) UIImageView *ecologicalView;
/// 服务信息
@property (nonatomic, strong) UIView *serviceInfoView;

@end

@implementation THKUserCenterHeaderView
TMUI_PropertySyntheSize(viewModel);

#pragma mark - Lifecycle (dealloc init viewDidLoad memoryWarning...)
- (void)thk_setupViews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.cornerView];
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.tagButton];
    [self addSubview:self.tipsButton];
    [self addSubview:self.followButton];
    [self addSubview:self.signatureLabel];
    [self addSubview:self.socialView];
    [self addSubview:self.storeButton];
    [self addSubview:self.ecologicalView];
    [self addSubview:self.serviceInfoView];
    
    [self makeConstraints];
}

- (void)makeConstraints{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(_viewModel.bgImageH);
    }];
    
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(165);
        make.height.mas_equalTo(40);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_viewModel.avatarTop);
        make.left.equalTo(self).inset(16);
        make.size.mas_equalTo(CGSizeMake(_viewModel.avatarH, _viewModel.avatarH));
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(186);
        make.right.equalTo(self).inset(16);
        make.size.mas_equalTo(CGSizeMake(80, 36));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(_viewModel.nameTop);
        make.left.equalTo(self.avatarImageView);
    }];
    
    [self.tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(_viewModel.tagTop);
        make.size.mas_equalTo(CGSizeMake(80, _viewModel.tagH));
    }];
    
    [self.tipsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagButton.mas_right).offset(10);
        make.centerY.equalTo(self.tagButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(16);
        make.top.equalTo(self.tagButton.mas_bottom).offset(_viewModel.signatureTop);
        make.height.mas_equalTo(_viewModel.signatureH);
    }];
    
    [self.socialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(16);
        make.top.equalTo(self.signatureLabel.mas_bottom).offset(_viewModel.socialTop);
        make.height.mas_equalTo(_viewModel.socialH);
    }];
    
    [self.storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView);
        make.top.equalTo(self.socialView.mas_bottom).offset(_viewModel.storeTop);
        make.size.mas_equalTo(CGSizeMake(100, _viewModel.storeH));
    }];
    
    [self.ecologicalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeButton.mas_bottom).offset(_viewModel.ecologicalTop);
        make.left.right.equalTo(self).inset(16);
        make.height.mas_equalTo(_viewModel.ecologicalH);
    }];
    
    [self.serviceInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(16);
        make.top.equalTo(self.ecologicalView.mas_bottom).offset(_viewModel.serviceTop);
        make.height.mas_equalTo(_viewModel.serviceH);
    }];
}

- (void)bindViewModel{
    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self updateUI];
    }];
}

- (void)updateUI{
    self.nameLabel.text = self.viewModel.name;
    self.tagButton.text = self.viewModel.tagName;
    self.signatureLabel.text = self.viewModel.signature;
    [self.socialView bindViewModel:self.viewModel.socailViewModel];
    
    // 签名
    [self.signatureLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagButton.mas_bottom).offset(_viewModel.signatureTop);
        make.height.mas_equalTo(_viewModel.signatureH);
    }];
    // 店铺
    [self.storeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.socialView.mas_bottom).offset(_viewModel.storeTop);
        make.size.mas_equalTo(CGSizeMake(100, _viewModel.storeH));
    }];
    // 生态
    [self.ecologicalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeButton.mas_bottom).offset(_viewModel.ecologicalTop);
        make.height.mas_equalTo(_viewModel.ecologicalH);
    }];
    // 服务信息
    [self.serviceInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ecologicalView.mas_bottom).offset(_viewModel.serviceTop);
        make.height.mas_equalTo(_viewModel.serviceH);
    }];
    
}

#pragma mark - Public

#pragma mark - Event Respone

- (void)tapAvatar:(UITapGestureRecognizer *)tap{
    [THKShowBigImageViewController showBigImageWithImageView:(UIImageView *)tap.view transitionStyle:THKTransitionStylePush];
}

- (void)clickTagButton{
    NSLog(@"%s",__func__);
}

- (void)clickTipsButton{
    NSLog(@"%s",__func__);
}

- (void)clickFollowButton{
    NSLog(@"%s",__func__);
}


- (void)clickStoreButton{
    NSLog(@"%s",__func__);
}

#pragma mark - Delegate

#pragma mark - Private


#pragma mark - Getters and Setters
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"dec_banner_def"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIView *)cornerView{
    if (!_cornerView) {
        _cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40)];
        _cornerView.backgroundColor = UIColor.whiteColor;
        _cornerView.layer.cornerRadius = 12;
    }
    return _cornerView;
}

- (THKShadowImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[THKShadowImageView alloc] init];
        _avatarImageView.contentImageView.image = [UIImage imageNamed:@"eren"];
        _avatarImageView.contentImageView.layer.cornerRadius = _viewModel.avatarH/2 ?: 36;
        _avatarImageView.contentImageView.layer.borderColor = UIColor.whiteColor.CGColor;
        _avatarImageView.contentImageView.layer.borderWidth = 2;
        _avatarImageView.contentImageView.layer.masksToBounds = YES;
        _avatarImageView.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.contentImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatar:)];
        [_avatarImageView.contentImageView addGestureRecognizer:tap];
        [_avatarImageView setLayerShadow:UIColorHexString(@"#A9A8BA") opacity:0.2 offset:CGSizeMake(0, 2) radius:2];
    }
    return _avatarImageView;
}


- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [[UIButton alloc] init];
        _followButton.backgroundColor = UIColor.grayColor;
        [_followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
        _followButton.titleLabel.font = UIFontMedium(16);
        [_followButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _followButton.backgroundColor = UIColorHexString(@"#24C77E");
        _followButton.layer.cornerRadius = 6;
        [_followButton addTarget:self action:@selector(clickFollowButton)];
    }
    return _followButton;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = UIFontMedium(22);
        _nameLabel.textColor = UIColorHexString(@"111111");
    }
    return _nameLabel;
}

- (UIButton *)tagButton{
    if (!_tagButton) {
        _tagButton = [[UIButton alloc] init];
        [_tagButton setImage:[UIImage imageNamed:@"user_tag_icon"] forState:UIControlStateNormal];
        [_tagButton setTitleColor:UIColorHexString(@"#878B99") forState:UIControlStateNormal];
        _tagButton.titleLabel.font = UIFont(12);
        _tagButton.backgroundColor = UIColorHexString(@"#F0F1F5");
        _tagButton.layer.cornerRadius = _viewModel.tagH/2?:12;
        _tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [_tagButton addTarget:self action:@selector(clickTagButton)];
    }
    return _tagButton;
}

- (UIButton *)tipsButton{
    if (!_tipsButton) {
        _tipsButton = [[UIButton alloc] init];
        [_tipsButton setTitle:@"?" forState:UIControlStateNormal];
        [_tipsButton setTitleColor:UIColorHexString(@"#BABDC6") forState:UIControlStateNormal];
        _tipsButton.titleLabel.font = UIFont(12);
        _tipsButton.layer.cornerRadius = 8;
        _tipsButton.layer.borderColor = UIColorHexString(@"#BABDC6").CGColor;
        _tipsButton.layer.borderWidth = 0.5;
        [_tipsButton addTarget:self action:@selector(clickTipsButton)];
    }
    return _tipsButton;
}

- (UILabel *)signatureLabel{
    if (!_signatureLabel) {
        _signatureLabel = [[UILabel alloc] init];
        _signatureLabel.numberOfLines = 0;
        _signatureLabel.textColor = UIColorHexString(@"#878B99");
        _signatureLabel.font = UIFont(12);
    }
    return _signatureLabel;
}

- (THKUserSocialView *)socialView{
    if (!_socialView) {
        _socialView = [[THKUserSocialView alloc] init];
    }
    return _socialView;
}

- (UIButton *)storeButton{
    if (!_storeButton) {
        _storeButton = [[UIButton alloc] init];
        [_storeButton setImage:[UIImage imageNamed:@"user_tag_icon"] forState:UIControlStateNormal];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"TA的店铺  ＞" attributes:@{NSFontAttributeName:UIFont(12),NSForegroundColorAttributeName:UIColorHexString(@"#111111")}];
        [attrStr addAttributes:@{NSFontAttributeName:UIFont(10),
                                 NSForegroundColorAttributeName:UIColorHexString(@"#878B99"),
                                 NSBaselineOffsetAttributeName:@1
        } range:NSMakeRange(7, 1)];
        [_storeButton setAttributedTitle:attrStr forState:UIControlStateNormal];
        _storeButton.titleLabel.font = UIFont(12);
        _storeButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _storeButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_storeButton addTarget:self action:@selector(clickStoreButton)];
        _storeButton.layer.masksToBounds = YES;
    }
    return _storeButton;
}

- (UIImageView *)ecologicalView{
    if (!_ecologicalView) {
        _ecologicalView = [[UIImageView alloc] init];
        _ecologicalView.image = [UIImage imageNamed:@"dec_banner_def"];
        _ecologicalView.contentMode = UIViewContentModeScaleAspectFill;
        _ecologicalView.layer.cornerRadius = 4;
        _ecologicalView.layer.masksToBounds = YES;
    }
    return _ecologicalView;
}

- (UIView *)serviceInfoView{
    if (!_serviceInfoView) {
        _serviceInfoView = [[UIView alloc] init];
        _serviceInfoView.backgroundColor = UIColor.orangeColor;
    }
    return _serviceInfoView;
}

#pragma mark - Supperclass

#pragma mark - NSObject




@end
