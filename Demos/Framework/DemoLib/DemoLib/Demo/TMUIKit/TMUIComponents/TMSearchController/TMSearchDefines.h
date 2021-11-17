//
//  TMSearchDefines.h
//  Pods
//
//  Created by nigel.ning on 2020/8/10.
//

#ifndef TMSearchDefines_h
#define TMSearchDefines_h

#import <Foundation/Foundation.h>

///相关vc显示和消失的事件枚举值
typedef NS_ENUM(NSInteger, TMSearchControllerPageEvent) {
    TMSearchControllerPageEventWillPresent = 0,
    TMSearchControllerPageEventDidPresent,
    TMSearchControllerPageEventWillDismiss,
    TMSearchControllerPageEventDidDismiss,
};


#endif /* TMSearchDefines_h */
