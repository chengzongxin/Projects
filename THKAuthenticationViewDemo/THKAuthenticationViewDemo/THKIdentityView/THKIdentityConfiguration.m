//
//  THKIdentityConfiguration.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import "THKIdentityConfiguration.h"
#import <YYKit.h>
@implementation THKIdentityConfiguration

+ (instancetype)configWithIdentityType:(NSInteger)type{
    if (type == 0) {
        return nil;
    }
    THKIdentityConfiguration *config = [[THKIdentityConfiguration alloc] init];
    [config configDefaultWithType:type];
    return config;
}


/// 配置接口不通的时候使用默认配置
/// 10-家居达人 11-设计师机构 12-品牌商家 13-官方认证 14-装企认证
/// @param type 认证类型
- (void)configDefaultWithType:(NSInteger)type{
    switch (type) {
        case 0:
        {
            
        }
            break;
        case 999:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_orange"];
            self.text = @"作者";
            self.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
            self.backgroundColor = UIColorHex(878B99);
            self.textColor = UIColor.whiteColor;
            self.iconSize = self.icon.size;
        }
            break;
        case 10:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_green"];
            self.text = @"家居达人";
            self.font = [UIFont systemFontOfSize:12];
            self.backgroundColor = UIColorHex(FEF6E8);
            self.textColor = UIColorHex(EB9002);
            self.iconSize = self.icon.size;
        }
            break;
        case 11:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_yellow"];
            self.text = @"官方认证";
            self.font = [UIFont systemFontOfSize:12];
            self.backgroundColor = [UIColorHex(24C77E) colorWithAlphaComponent:0.1];;
            self.textColor = UIColorHex(24C77E);
            self.iconSize = self.icon.size;
        }
            break;
        case 12:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_yellow"];
            self.text = @"设计机构";
            self.font = [UIFont systemFontOfSize:12];
            self.backgroundColor = UIColorHex(ECF3FC);
            self.textColor = UIColorHex(3380D9);
            self.iconSize = self.icon.size;
        }
            break;
        case 13:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_yellow"];
            self.text = @"品牌商家";
            self.font = [UIFont systemFontOfSize:12];
            self.backgroundColor = UIColorHex(ECF3FC);
            self.textColor = UIColorHex(3380D9);
            self.iconSize = self.icon.size;
        }
            break;
        case 14:
        {
            self.icon = [UIImage imageNamed:@"icon_identity_yellow"];
            self.text = @"装修公司";
            self.font = [UIFont systemFontOfSize:12];
            self.backgroundColor = UIColorHex(ECF3FC);
            self.textColor = UIColorHex(3380D9);
            self.iconSize = self.icon.size;
        }
            break;
            
        default:
            break;
    }
}




@end
