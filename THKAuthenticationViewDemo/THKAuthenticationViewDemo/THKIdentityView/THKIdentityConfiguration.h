//
//  THKIdentityConfiguration.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THKIdentityConfiguration : NSObject
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGSize iconSize;


+ (instancetype)configWithIdentityType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
