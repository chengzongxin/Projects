//
//  AppDelegate.m
//  IM
//
//  Created by Joe.cheng on 2021/7/1.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import <RongIMKit/RongIMKit.h>
#import "User.h"
#import <AdSupport/AdSupport.h>

#define APP_KEY @"mgb7ka1nmwueg"

#define DEVICE_ADID [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]


@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate,RCIMGroupInfoDataSource,RCIMGroupMemberDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] clearUserInfoCache];
    [[RCIM sharedRCIM] initWithAppKey:APP_KEY];
    
    if ([DEVICE_ADID isEqualToString:User.eren.ADID]) {
        User.sharedInstance.user = User.eren;
    }else if ([DEVICE_ADID isEqualToString:User.mikasa.ADID]) {
        User.sharedInstance.user = User.mikasa;
    }else if ([DEVICE_ADID isEqualToString:User.armin.ADID]) {
        User.sharedInstance.user = User.armin;
    }
    
    //链接融云
    [[RCIM sharedRCIM] connectWithToken:User.sharedInstance.user.token
                               dbOpened:^(RCDBErrorCode code) {
        NSLog(@"%zd",code);;
    }
                                success:^(NSString *userId) {
        NSLog(@"%@",userId);
        [RCIM sharedRCIM].currentUserInfo = User.sharedInstance.user.rcUser;
    }
                                  error:^(RCConnectErrorCode status) {
        NSLog(@"%ld",(long)status);
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = TabBarController.new;
    [self.window makeKeyAndVisible];
    
    //添加用户信息代理
    [RCIM sharedRCIM].userInfoDataSource = self;
    //设置用户信息在本地持久化存储。SDK 获取过的用户信息将保存在数据库中，即使 App 重新启动也能再次读取。
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    [RCIM sharedRCIM].groupInfoDataSource = self;
    
    [RCIM sharedRCIM].groupMemberDataSource = self;


    
    return YES;
}

// 实现用户信息提供者的代理函数
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    //开发者需要将 userId 对应的用户信息返回，下列仅为示例
      //实际项目中，开发者有可能需要到 App Server 获取 userId 对应的用户信息，再通过 completion 返回给 SDK。
    if ([userId isEqualToString:User.eren.ID]) {
        if (completion) {
            completion(User.eren.rcUser);
        }
    }else if ([userId isEqualToString:User.mikasa.ID]) {
        if (completion) {
            completion(User.mikasa.rcUser);
        }
    }else if ([userId isEqualToString:User.armin.ID]) {
        if (completion) {
            completion(User.armin.rcUser);
        }
    }
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status{
    NSLog(@"%zd",status);
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    NSLog(@"%@",message);
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    if ([groupId length] == 0)
        return;
    //开发者调自己的服务器接口根据 userID 异步请求数据
//    [RCDHTTPTOOL getGroupByID:groupId
//            successCompletion:^(RCDGroupInfo *group) {
//                completion(group);
//            }];
    RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:@"尤弥尔的子民" portraitUri:@"https://img0.baidu.com/it/u=3197589023,2199583007&fm=26&fmt=auto&gp=0.jpg"];
    completion(group);
}

- (void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock {
    //开发者回调自己服务器获取信息
//    [RCDGroupManager getGroupMembersFromServer:groupId
//                                      complete:^(NSArray<NSString *> *_Nonnull memberIdList) {
//                                          if (resultBlock) {
//                                              resultBlock(memberIdList);
//                                          }
//                                      }];
}




@end
