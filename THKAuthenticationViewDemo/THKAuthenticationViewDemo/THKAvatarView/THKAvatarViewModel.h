//
//  THKAvatarViewModel.h
//  HouseKeeper
//
//  Created by Joe.cheng on 2021/2/7.
//  Copyright © 2021 binxun. All rights reserved.
//

#import "THKViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface THKAvatarViewModel : THKViewModel
/// 头像URL
@property(nonatomic, strong) NSString *avatarUrl;
/// 头像占位图片
@property(nonatomic, strong) UIImage *placeHolderImage;
/// 标识类型，如果不传则不显示标识
@property(nonatomic, assign) NSInteger identityType;
/// 标识二级类型，没有二级标识类型可不传
@property(nonatomic, assign) NSInteger identitySubType;
/// 是否隐藏标识，默认不隐藏（显示）
@property(nonatomic, assign) BOOL isHiddenIdentity;
/// 用户可指定identityIconView的展示尺寸，默认值为{10, 10}
@property (nonatomic, assign)CGSize identityIconSize;
/// 用户可指定identityIconView展示时中心位置的偏移。默认为{0, 0}
@property (nonatomic, assign)CGPoint identityIconCenterOffset;
/// 点击THKAvatarView回调
@property(nonatomic, strong) RACSubject *onTapSubject;


/// 创建VM对象,其他属性使用默认值，且没有二级标识类型使用
/// @param avatarUrl 头像URL
/// @param identityType 标识类型
- (instancetype)initWithAvatarUrl:(NSString *)avatarUrl
                     identityType:(NSInteger)identityType;

/// 创建VM对象
/// @param avatarUrl 头像URL
/// @param placeHolderImage 头像占位图片
/// @param identityType 标识类型
/// @param identitySubType 标识二级类型，没有二级标识类型可不传
- (instancetype)initWithAvatarUrl:(NSString *)avatarUrl
                 placeHolderImage:(UIImage *)placeHolderImage
                     identityType:(NSInteger)identityType
                  identitySubType:(NSInteger)identitySubType;

@end

NS_ASSUME_NONNULL_END
