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
@property (nonatomic, strong) V2TIMGroupMemberInfo *info;
@property (nonatomic, strong) NSString *text;

+ (instancetype)modelWithMsgID:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
