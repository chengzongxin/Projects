//
//  MessageModel.h
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import <Foundation/Foundation.h>
#import <ImSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject

@property (nonatomic, strong) NSString *msgID;
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *userID;

+ (instancetype)modelWithV2TIMMessage:(V2TIMMessage *)msg;

+ (instancetype)modelWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
