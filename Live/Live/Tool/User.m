//
//  User.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "User.h"

@implementation User

+ (instancetype)shareInstance{
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}
@end
