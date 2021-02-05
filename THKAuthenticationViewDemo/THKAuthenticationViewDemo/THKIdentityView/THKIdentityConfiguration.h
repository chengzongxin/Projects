//
//  THKIdentityConfiguration.h
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THKIdentityConfiguration : NSObject

@property (nonatomic, strong) UIImage *iconLocal;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGSize iconSize;


@end

NS_ASSUME_NONNULL_END
