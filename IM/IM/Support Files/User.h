//
//  User.h
//  IM
//
//  Created by Joe.cheng on 2021/8/13.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *portraitUri;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *ADID;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong, class) User *eren;
@property (nonatomic, strong, class) User *mikasa;
@property (nonatomic, strong, class) User *armin;

- (RCUserInfo *)rcUser;


SHARED_INSTANCE_FOR_HEADER

@end

NS_ASSUME_NONNULL_END
