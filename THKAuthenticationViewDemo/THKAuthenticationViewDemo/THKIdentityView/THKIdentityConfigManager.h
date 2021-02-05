//
//  THKIdentityConfigManager.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/5.
//

#import <UIKit/UIKit.h>
#import "THKIdentityConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface THKIdentityConfigManager : NSObject

/// 单例管理
+ (instancetype)shareInstane;

/// 加载配置，会加载本地和远程两个配置
- (void)loadConfig;

/// 获取配置
/// @param type 标识类型
/// @param subType 二级标识类型
- (THKIdentityConfiguration *)fetchConfigWithType:(NSInteger)type subType:(NSInteger)subType;


@end

NS_ASSUME_NONNULL_END
