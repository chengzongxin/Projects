//
//  THKIdentityModel.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import "THKIdentityTypeModel.h"
#import <MJExtension.h>

@implementation THKIdentityTypeModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"subCategory":THKIdentityTypeModelSubCategory.class};
}

+ (NSArray *)model{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"App启动配置接口.json" ofType:nil];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return [THKIdentityTypeModel mj_objectArrayWithKeyValuesArray:json[@"result"][@"identify"]];
}

@end

@implementation THKIdentityTypeModelSubCategory
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"textData":THKIdentityTypeModelSubCategoryTextData.class};
}
@end

@implementation THKIdentityTypeModelSubCategoryTextData

@end
