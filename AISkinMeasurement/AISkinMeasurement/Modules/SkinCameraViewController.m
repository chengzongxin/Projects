//
//  CameraViewController.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/20.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinCameraViewController.h"
#import <Photos/Photos.h>
#import "SCPermissionsView.h"
@interface SkinCameraViewController () <SCPermissionsViewDelegate>
@property (nonatomic, strong) SCPermissionsView *permissionsView;
@end

@implementation SkinCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.permissionsView.hasAllPermissions) { // 没有权限
        [self.view addSubview:self.permissionsView];
    }
}

#pragma mark - getter/setter

- (SCPermissionsView *)permissionsView {
    if (_permissionsView == nil) {
        _permissionsView = [[SCPermissionsView alloc] initWithFrame:self.view.bounds];
        _permissionsView.delegate = self;
    }
    return _permissionsView;
}
// PermissionView 权限回调
- (void)permissionsViewDidHasAllPermissions:(SCPermissionsView *_Nullable)pv{}

@end
