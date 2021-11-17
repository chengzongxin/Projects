//
//  AppDelegate.m
//  blockcrash
//
//  Created by Joe.cheng on 2021/3/25.
//

#import "AppDelegate.h"
#import "fishhook.h"
#import "UncaughtExceptionHandler.h"

static void (*sys_nslog)(NSString *format, ...);

typedef NS_ENUM(NSUInteger, CJJBlockHookPosition) {
    CJJBlockHookPositionBefore = 0,
    CJJBlockHookPositionAfter,
    CJJBlockHookPositionReplace,
    CJJBlockHookPositionDoNothing
};

void myNSLog(NSString *format, ...) {
    format = [format stringByAppendingFormat: @" hook 住了"];
    sys_nslog(format);
}

void block_invoke(NSString *format, ...) {
    format = [format stringByAppendingFormat: @" hook 住了"];
    sys_nslog(format);
}

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    InstallUncaughtExceptionHandler();
//    InstallUncaughtExceptionHandler();
//    struct rebinding nslog;
//    
//    nslog.name = "NSLog";
//    nslog.replacement = myNSLog;
//    nslog.replaced = (void *)&sys_nslog;
//    
//    struct rebinding rebs[1] = { nslog };
//    
//    rebind_symbols(rebs, 1);
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
