//
//  User.h
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *faceUrl;

+ (instancetype)shareInstance;


@end

NS_ASSUME_NONNULL_END
