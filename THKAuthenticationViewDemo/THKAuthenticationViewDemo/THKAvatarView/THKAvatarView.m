//
//  TUserAvatarView.m
//  UIComponentSamples
//
//  Created by Joe.cheng on 2021/2/5.
//

#import "THKAvatarView.h"

@interface THKAvatarView()
@property (nonatomic, strong) THKAvatarViewModel *viewModel;
@property (nonatomic, strong) UIImageView *avatarImgView;
@property (nonatomic, strong) THKIdentityView *identityView;
@end

@implementation THKAvatarView
@dynamic viewModel;
@synthesize avatarImgView = _avatarImgView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUIs];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadUIs];
}

#pragma mark - ui layout
- (void)loadUIs {
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self addGestureRecognizer:tap];
    float minV = MIN(self.bounds.size.width, self.bounds.size.height);
    CGRect rt = CGRectMake((self.bounds.size.width - minV)/2, (self.bounds.size.height - minV)/2, minV, minV);
    self.avatarImgView = [[UIImageView alloc] initWithFrame:rt];
    self.avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImgView.clipsToBounds = YES;
    self.avatarImgView.layer.cornerRadius = minV/2;
    [self addSubview:self.avatarImgView];
    
    [self addSubview:self.identityView];
    [_identityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.clipsToBounds = NO;
    
    float minV = MIN(self.bounds.size.width, self.bounds.size.height);
    self.avatarImgView.frame = CGRectMake((self.bounds.size.width - minV)/2, (self.bounds.size.height - minV)/2, minV, minV);
    self.avatarImgView.layer.cornerRadius = minV/2;
}


/// MARK: 外部调用 -[view bindViewModel:vm] 后会调用这个方法，在这里设置数据 & 刷新UI
- (void)bindViewModel{
    [self.avatarImgView loadImageWithUrlStr:self.viewModel.avatarUrl placeHolderImage:self.viewModel.placeHolderImage ?: kDefaultHeadImg];
    
    if (self.viewModel.isHiddenIdentity) {
        self.identityView.hidden = YES;
    }else{
        self.identityView.hidden = NO;
        [_identityView setType:self.viewModel.identityType subType:self.viewModel.identitySubType];
        
        if (_identityView.superview) {
            [_identityView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.viewModel.identityIconCenterOffset.y);
                make.right.mas_equalTo(self.viewModel.identityIconCenterOffset.x);
                make.size.mas_equalTo(self.viewModel.identityIconSize);
            }];
        }
    }
}

#pragma mark - inner logics

- (void)tapView {
    if (self.viewModel.onTapSubject) {
        [self.viewModel.onTapSubject sendNext:self];
    }
}

#pragma mark - getters

- (THKIdentityView *)identityView{
    if (!_identityView) {
        _identityView = [[THKIdentityView alloc] initWithType:0 subType:0 style:THKIdentityViewStyle_Icon];
    }
    return _identityView;
}

@end
