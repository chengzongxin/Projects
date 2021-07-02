//
//  AppDelegate.m
//  IM
//
//  Created by Joe.cheng on 2021/7/1.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import <RongIMKit/RongIMKit.h>

#define APP_KEY @"mgb7ka1nmwueg"
#define USER_TOKEN_CHENG @"fka7JPdDsuRbidRL+WUP/KvSbxV38ExcajUVHsVKniw=@soh8.cn.rongnav.com;soh8.cn.rongcfg.com"
#define USER_TOKEN_888 @"Jg/q0irrKmReVmDwTxQFdu350oGVS796mpHYqZ/nAvE=@soh8.cn.rongnav.com;soh8.cn.rongcfg.com"


@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] initWithAppKey:APP_KEY];
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    [[RCIM sharedRCIM] connectWithToken:USER_TOKEN_CHENG
#elif TARGET_OS_IPHONE //真机
    [[RCIM sharedRCIM] connectWithToken:USER_TOKEN_888
#endif
                               dbOpened:^(RCDBErrorCode code) {
            NSLog(@"%zd",code);;
        }
                                success:^(NSString *userId) {
            NSLog(@"%@",userId);
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

    
    return YES;
}

// 实现用户信息提供者的代理函数
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    //开发者需要将 userId 对应的用户信息返回，下列仅为示例
      //实际项目中，开发者有可能需要到 App Server 获取 userId 对应的用户信息，再通过 completion 返回给 SDK。
    if ([userId isEqualToString:@"888"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:@"888" name:@"融融" portrait:@"https://sc04.alicdn.com/kf/Hfc94688e6ec14c01b711cf83288e4d6b9.jpg"];
        if (completion) {
            completion(userInfo);
        }
    }
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status{
    NSLog(@"%zd",status);
}

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    NSLog(@"%@",message);
}



@end
