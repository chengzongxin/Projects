//
//  THKUserSocialView.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import "THKView.h"
#import "THKUserSocialViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface THKUserSocialView : THKView
/// 关注数量
@property (nonatomic, strong) UIButton *followCountButton;
/// 粉丝数量
@property (nonatomic, strong) UIButton *fansCountButton;
/// 获赞和收藏
@property (nonatomic, strong) UIButton *beCollectCountButton;

@end

NS_ASSUME_NONNULL_END
