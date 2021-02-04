//
//  THKIdentityModel.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import <UIKit/UIKit.h>
@class THKIdentityTypeModelIdentify;
@class THKIdentityTypeModelSubCategory;
@class THKIdentityTypeModelSubCategoryTextData;
NS_ASSUME_NONNULL_BEGIN

@interface THKIdentityTypeModel : NSObject

@property(nonatomic, strong) NSArray <THKIdentityTypeModelIdentify *> *identify;

/// 创建默认配置模型
+ (instancetype)modelDefault;

@end

@interface THKIdentityTypeModelIdentify : NSObject

@property(nonatomic, assign) NSInteger identificationType;
@property(nonatomic, strong) NSArray <THKIdentityTypeModelSubCategory *> *subCategory;


@end

@interface THKIdentityTypeModelSubCategory : NSObject
@property(nonatomic, assign) NSInteger subCategory;
@property(nonatomic, strong) NSString *identificationPic;
@property(nonatomic, assign) CGFloat iconWidth;
@property(nonatomic, assign) CGFloat iconHeight;
@property(nonatomic, strong) THKIdentityTypeModelSubCategoryTextData *textData;
@end

@interface THKIdentityTypeModelSubCategoryTextData : NSObject
@property(nonatomic, strong) NSString *identificationDesc;
@property(nonatomic, strong) NSString *backgroundColor;// 十六进制背景颜色:#FFFFFF
@property(nonatomic, strong) NSString *textColor;// 十六进制背景颜色:#FFFFFF
@property(nonatomic, assign) NSInteger fontSize;

@end
NS_ASSUME_NONNULL_END
