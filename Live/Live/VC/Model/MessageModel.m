//
//  MessageModel.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "MessageModel.h"
#import "LiveTool.h"
#import "User.h"

@implementation MessageModel


+ (instancetype)modelWithV2TIMMessage:(V2TIMMessage *)msg{
    MessageModel *model = [[MessageModel alloc] init];
    model.msgID = msg.msgID;
    model.groupID = msg.groupID;
    model.text = msg.textElem.text;
    model.userID = msg.sender;
    model.nickName = msg.nickName;
    model.faceUrl = msg.faceURL;
    return model;
}

+ (instancetype)modelWithText:(NSString *)text{
    MessageModel *model = [[MessageModel alloc] init];
    model.msgID = @"";
    model.groupID = [LiveTool getGroupId];
    model.text = text;
    model.userID = [LiveTool getUserId];
    model.nickName = User.shareInstance.nickName;
    model.faceUrl = User.shareInstance.faceUrl;
    return model;
}

@end
