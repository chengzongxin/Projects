//
//  IMTool.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "IMTool.h"
#import <ImSDK.h>
#import "LiveTool.h"
#import "GenerateTestUserSig.h"
@interface IMTool ()
<
V2TIMSDKListener,
V2TIMGroupListener,
V2TIMSimpleMsgListener,
V2TIMAdvancedMsgListener
>

@property (nonatomic, strong) id<MessageListenerDelegate> listener;

@end

@implementation IMTool
+ (instancetype)shareInstance{
    static IMTool *imTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imTool = [[IMTool alloc] init];
    });
    return imTool;
}


- (void)startWithMsgListener:(id<MessageListenerDelegate>)listener{
    // 1. 从 IM 控制台获取应用 SDKAppID，详情请参考 SDKAppID。
    // 2. 初始化 config 对象
    V2TIMSDKConfig *config = [[V2TIMSDKConfig alloc] init];
    // 3. 指定 log 输出级别，详情请参考 [SDKConfig](#SDKAppID)。
    config.logLevel = V2TIM_LOG_INFO;
    // 4. 初始化 SDK 并设置 V2TIMSDKListener 的监听对象。
    // initSDK 后 SDK 会自动连接网络，网络连接状态可以在 V2TIMSDKListener 回调里面监听。
    [[V2TIMManager sharedInstance] initSDK:SDKAppID config:config listener:self];
    
    self.listener = listener;
    
}

// 5. 监听 V2TIMSDKListener 回调
- (void)onConnecting {
    // 正在连接到腾讯云服务器
    NSLog(@"onConnecting");
}
- (void)onConnectSuccess {
    // 已经成功连接到腾讯云服务器
    NSLog(@"%s",__func__);
    NSString *userId = [LiveTool getUserId];
    NSString *userSig = [GenerateTestUserSig genTestUserSig:userId];
    [[V2TIMManager sharedInstance] login:userId userSig:userSig succ:^{
        NSLog(@"login success");
        [[V2TIMManager sharedInstance] setGroupListener:self];
        if ([[LiveTool getUserId] containsString:@"593a4d"]) {
            // simulator
            [self createGroup];
        }else{
            [self joinGroup];
        }
    } fail:^(int code, NSString *desc) {
        NSLog(@"login fail code = %d,desc = %@",code,desc);
    }];
}
- (void)onConnectFailed:(int)code err:(NSString*)err {
    // 连接腾讯云服务器失败
    NSLog(@"%s,code = %d,err = %@",__func__,code,err);
}


// succ 881122
- (void)createGroup{
    // 示例代码：使用高级版 createGroup 创建一个工作群
    V2TIMGroupInfo *info = [[V2TIMGroupInfo alloc] init];
    info.groupID = [LiveTool getGroupId];
    info.groupName = @"LiveRoom";
    info.groupType = @"AVChatRoom";
//    NSMutableArray *memberList = [NSMutableArray array];
//    V2TIMCreateGroupMemberInfo *memberInfo = [[V2TIMCreateGroupMemberInfo alloc] init];
//    memberInfo.userID = [LiveTool getUserId];
//    [memberList addObject:memberInfo];
    [[V2TIMManager sharedInstance] createGroup:info memberList:nil succ:^(NSString *groupID) {
      // 创建群组成功
        NSLog(@"succ groupID = %@",groupID);
        [self addGroupMsgLister];
    } fail:^(int code, NSString *msg) {
      // 创建群组失败
        NSLog(@"fail code = %d,msg =%@",code,msg);
        // fail code = 10025,msg =group id has be used by youself!
        if (code == 10025) {
            [self joinGroup];
        }
    }];
}


- (void)joinGroup{
    [[V2TIMManager sharedInstance] joinGroup:[LiveTool getGroupId] msg:@"" succ:^{
        NSLog(@"join group succ");
        [self addGroupMsgLister];
    } fail:^(int code, NSString *desc) {
        NSLog(@"fail join group code = %d,msg =%@",code,desc);
    }];
}

- (void)addGroupMsgLister{
    [[V2TIMManager sharedInstance] addSimpleMsgListener:self];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
}

- (void)onMemberEnter:(NSString *)groupID memberList:(NSArray<V2TIMGroupMemberInfo *> *)memberList{
    NSLog(@"onMemberEnter %@,%@",groupID,memberList);
}


/// 收到群文本消息
- (void)onRecvGroupTextMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info text:(NSString *)text{
    NSLog(@"onRecvGroupTextMessage");
}

/// 收到群自定义（信令）消息
- (void)onRecvGroupCustomMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info customData:(NSData *)data{
    NSLog(@"onRecvGroupCustomMessage");
}

/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSLog(@"onRecvNewMessage");
    MessageModel *message = [MessageModel modelWithV2TIMMessage:msg];
    if ([self.listener respondsToSelector:@selector(onNewMessage:)]) {
        [self.listener onNewMessage:message];
    }
}


@end
