//
//  MessageModel.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "MessageModel.h"

@implementation MessageModel

+ (instancetype)modelWithMsgID:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info text:(NSString *)text{
    MessageModel *model = [[MessageModel alloc] init];
    model.msgID = msgID;
    model.groupID = groupID;
    model.info = info;
    model.text = text;
    return model;
}

@end
