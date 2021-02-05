//
//  THKIdentityConfiguration.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import "THKIdentityConfiguration.h"
#import "THKIdentityTypeModel.h"

@implementation THKIdentityConfiguration
//
//+ (instancetype)configWithIdentityType:(NSInteger)type subType:(NSInteger)subType{
//    if (type == 0) {
//        return nil;
//    }
//    
//    THKIdentityConfiguration *config = [[THKIdentityConfiguration alloc] init];
//    // 先使用默认配置
////    [config configDefaultWithType:type];
//    // 本地默认json配置
//    NSArray <THKIdentityTypeModelIdentify *> *models = [THKIdentityTypeModel modelDefault].identify;
//    
//    [config configWithModel:models type:type subType:subType];
//    config.iconLocal = [self iconImg:type subType:subType];
//    return config;
//}
//
//
///// 使用接口返回的模型配置
///// @param type 认证类型
//- (void)configWithModel:(NSArray <THKIdentityTypeModelIdentify *> *)models type:(NSInteger)type subType:(NSInteger)subType{
//
//    THKIdentityTypeModelSubCategory *model;
//
//    for (THKIdentityTypeModelIdentify *m in models) {
//        if (m.identificationType == type) {
//            if (subType == 0) {
//                model = m.subCategory.firstObject;
//            }else{
//                if (subType > m.subCategory.count || m.subCategory.count == 0) {
//                    break;
//                }
//                for (THKIdentityTypeModelSubCategory *category in m.subCategory) {
//                    if (category.subCategory == subType) {
//                        model = category;
//                    }
//                }
//            }
//            break;
//        }
//    }
//
//    if (model) {
//        self.iconUrl = model.identificationPic;
//        self.text = model.textData.identificationDesc;
//        self.font = [UIFont systemFontOfSize:model.textData.fontSize];
//        self.backgroundColor = [UIColor colorWithHexString:model.textData.backgroundColor];
//        self.textColor = [UIColor colorWithHexString:model.textData.textColor];
//        self.iconSize = CGSizeMake(model.iconWidth, model.iconHeight);
//    }
//}


///// 配置接口不通的时候使用默认配置
///// 10-家居达人 11-设计师机构 12-品牌商家 13-官方认证 14-装企认证
///// @param type 认证类型
//- (void)configDefaultWithType:(NSInteger)type{
//    switch (type) {
//        case 0:
//        {
//
//        }
//            break;
//        case 10:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_orange"];
//            self.text = @"家居达人";
//            self.font = [UIFont systemFontOfSize:12];
//            self.backgroundColor = UIColorHex(FEF6E8);
//            self.textColor = UIColorHex(EB9002);
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//        case 11:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_green"];
//            self.text = @"官方认证";
//            self.font = [UIFont systemFontOfSize:12];
//            self.backgroundColor = [UIColorHex(24C77E) colorWithAlphaComponent:0.1];;
//            self.textColor = UIColorHex(24C77E);
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//        case 12:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_yellow"];
//            self.text = @"设计机构";
//            self.font = [UIFont systemFontOfSize:12];
//            self.backgroundColor = UIColorHex(ECF3FC);
//            self.textColor = UIColorHex(3380D9);
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//        case 13:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_yellow"];
//            self.text = @"品牌商家";
//            self.font = [UIFont systemFontOfSize:12];
//            self.backgroundColor = UIColorHex(ECF3FC);
//            self.textColor = UIColorHex(3380D9);
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//        case 14:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_yellow"];
//            self.text = @"装修公司";
//            self.font = [UIFont systemFontOfSize:12];
//            self.backgroundColor = UIColorHex(ECF3FC);
//            self.textColor = UIColorHex(3380D9);
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//        case 999:
//        {
//            self.iconLocal = [UIImage imageNamed:@"icon_identity_orange"];
//            self.text = @"作者";
//            self.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
//            self.backgroundColor = UIColorHex(878B99);
//            self.textColor = UIColor.whiteColor;
//            self.iconSize = CGSizeMake(16, 16);
//        }
//            break;
//
//        default:
//            break;
//    }
//}




@end
