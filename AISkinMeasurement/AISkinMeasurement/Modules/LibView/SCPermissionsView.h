//
//  SCPermissionsView.h
//  SCCamera
//
//  Created by SeacenLiu on 2019/4/11.
//  Copyright © 2019 SeacenLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCPermissionsView;
@protocol SCPermissionsViewDelegate <NSObject>
- (void)permissionsViewDidHasAllPermissions:(SCPermissionsView *_Nullable)pv;
@end

NS_ASSUME_NONNULL_BEGIN

@interface SCPermissionsView : UIView
@property (nonatomic, weak) id<SCPermissionsViewDelegate> delegate;

/// 有相机和麦克风的权限(必须调用getter方法)
@property (nonatomic, assign, readonly) BOOL hasAllPermissions;

@end

NS_ASSUME_NONNULL_END
