//
//  THKIdentityConfigManager.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/5.
//

#import "THKIdentityConfigManager.h"
#import "THKIdentityTypeModel.h"
#import <YYKit.h>
#import "THKPersonalDesignerConfigRequest.h"

@interface THKIdentityConfigManager ()

@property(nonatomic, strong) THKIdentityTypeModel *localConfig;
@property(nonatomic, strong) THKIdentityTypeModel *remoteConfig;

@end

@implementation THKIdentityConfigManager


+ (instancetype)shareInstane {
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
    });
    return shareInstance;
}


/// 加载配置
- (void)loadConfig{
    // 加载本地配置
    [self loadCacheConfig];
    // 加载远程配置
    [self loadRemoteConfig];
}


- (void)loadCacheConfig{
    self.localConfig = [THKIdentityTypeModel modelDefault];
}

- (void)loadRemoteConfig{
    THKPersonalDesignerConfigRequest *request = [[THKPersonalDesignerConfigRequest alloc] init];
    @weakify(self);
    [request.rac_requestSignal subscribeNext:^(THKPersonalDesignerConfigResponse *response) {
        if (response.status == THKStatusSuccess) {
            @strongify(self);
            self.remoteConfig = response.data;
        }
    }];
}


- (THKIdentityConfiguration *)fetchConfigWithType:(NSInteger)type subType:(NSInteger)subType{
    THKIdentityTypeModel *remoteConfig = THKIdentityConfigManager.shareInstane.remoteConfig;
    
    THKIdentityConfiguration *config = [self configWithModel:remoteConfig type:type subType:subType];
    if (config) {
        return config;
    }
    
    THKIdentityTypeModel *localConfig = THKIdentityConfigManager.shareInstane.localConfig;
    config = [self configWithModel:localConfig type:type subType:subType];
    return config;
}


/// 使用接口返回的模型配置
/// @param type 认证类型
- (THKIdentityConfiguration *)configWithModel:(THKIdentityTypeModel *)configModel type:(NSInteger)type subType:(NSInteger)subType{

    NSArray *models = configModel.identify;
    if (models.count == 0) return nil;
    
    THKIdentityTypeModelSubCategory *model;

    for (THKIdentityTypeModelIdentify *m in models) {
        if (m.identificationType == type) {
            if (subType == 0) {
                model = m.subCategory.firstObject;
            }else{
                if (subType > m.subCategory.count || m.subCategory.count == 0) {
                    break;
                }
                for (THKIdentityTypeModelSubCategory *category in m.subCategory) {
                    if (category.subCategory == subType) {
                        model = category;
                    }
                }
            }
            break;
        }
    }
    
    if (!model) {
        return nil;
    }

    THKIdentityConfiguration *config = [[THKIdentityConfiguration alloc] init];
    config.iconUrl = model.identificationPic;
    config.text = model.textData.identificationDesc;
    config.font = [UIFont systemFontOfSize:model.textData.fontSize];
    config.backgroundColor = [UIColor colorWithHexString:model.textData.backgroundColor];
    config.textColor = [UIColor colorWithHexString:model.textData.textColor];
    config.iconSize = CGSizeMake(model.iconWidth, model.iconHeight);
    config.iconLocal = [self iconImg:type subType:subType];
    return config;
}


- (UIImage *)iconImg:(NSInteger)type subType:(NSInteger)subType{
    switch (type) {
        case 6:
        case 11:
            return subType ? [UIImage imageNamed:@"icon_identity_orange"] : [UIImage imageNamed:@"icon_identity_green"];
        case 10:
            return [UIImage imageNamed:@"icon_identity_orange"];
        case 12:
            return [UIImage imageNamed:@"icon_identity_yellow"];
        case 13:
            return [UIImage imageNamed:@"icon_identity_yellow"];
        case 14:
            return [UIImage imageNamed:@"icon_identity_yellow"];
        default:
            break;
    }
    return nil;
}

@end
