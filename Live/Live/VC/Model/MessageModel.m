//
//  MessageModel.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "MessageModel.h"
#import "LiveTool.h"

@implementation MessageModel


+ (instancetype)modelWithV2TIMMessage:(V2TIMMessage *)msg{
    MessageModel *model = [[MessageModel alloc] init];
    model.msgID = msg.msgID;
    model.groupID = msg.groupID;
    model.text = msg.textElem.text;
    model.userID = msg.sender;
    return model;
}

+ (instancetype)modelWithText:(NSString *)text{
    MessageModel *model = [[MessageModel alloc] init];
    model.msgID = @"";
    model.groupID = [LiveTool getGroupId];
    model.text = text;
    model.userID = [LiveTool getUserId];
    return model;
}

@end
