//
//  IMTool.h
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN
/// 成功通用回调
typedef void (^IMSuccess)(void);
/// 失败通用回调
typedef void (^IMFail)(int code, NSString * desc);

@protocol MessageListenerDelegate <NSObject>
@optional
//
///// 收到 C2C 文本消息
//- (void)onRecvC2CTextMessage:(NSString *)msgID  sender:(V2TIMUserInfo *)info text:(NSString *)text;
//
///// 收到 C2C 自定义（信令）消息
//- (void)onRecvC2CCustomMessage:(NSString *)msgID  sender:(V2TIMUserInfo *)info customData:(NSData *)data;
//
///// 收到群文本消息
//- (void)onRecvGroupTextMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info text:(NSString *)text;

- (void)onNewMessage:(MessageModel *)message;


//
///// 收到群自定义（信令）消息
//- (void)onRecvGroupCustomMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info customData:(NSData *)data;
@end

@interface IMTool : NSObject

+ (instancetype)shareInstance;

- (void)startWithMsgListener:(id<MessageListenerDelegate>)listener;

- (void)sendText:(NSString *)text
            succ:(IMSuccess)succ
            fail:(IMFail)fail;

- (void)sendCustomMessage:(NSDictionary *)dict
                     succ:(IMSuccess)succ
                     fail:(IMFail)fail;

@end

NS_ASSUME_NONNULL_END
