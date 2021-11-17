//
//  UncaughtExceptionHandler.h
//  blockcrash
//
//  Created by Joe.cheng on 2021/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UncaughtExceptionHandler : NSObject{
    BOOL dismissed;
}
  
@end
void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);

NS_ASSUME_NONNULL_END
