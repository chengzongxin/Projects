//
//  BaseViewController.h
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import <UIKit/UIKit.h>

#import "AddressBarController.h"
#import "ScanQRController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<AddressBarControllerDelegate,ScanQRDelegate>

@property (nonatomic, strong) AddressBarController *addressBarController;  // 播放地址/二维码扫描 工具栏
@end

NS_ASSUME_NONNULL_END
