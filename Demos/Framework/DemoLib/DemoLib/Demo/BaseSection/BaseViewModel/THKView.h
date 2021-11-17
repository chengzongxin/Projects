//
//  THKView.h
//  HouseKeeper
//
//  Created by 荀青锋 on 2019/5/6.
//  Copyright © 2019 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "THKViewModel.h"

@interface THKView : UIView

@property (nonatomic, strong, readonly) THKViewModel *viewModel;


/*
 initWithViewModel 与 initWithModel 二者选其一，
 bindWithModel: 与 bindViewModel:同理
 */

/// 用ViewModel初始化View
/// @param viewModel
- (instancetype)initWithViewModel:(THKViewModel *)viewModel DEPRECATED_MSG_ATTRIBUTE("Please use bindViewModel:");


/// 用model初始化View
/// @param model
- (instancetype)initWithModel:(id)model DEPRECATED_MSG_ATTRIBUTE("Please use bindWithModel:");

- (void)bindViewModel;

/// 将model绑定到view
/// @param model 数据
- (void)bindWithModel:(id)model;


/// view绑定viewModel
/// @param viewModel
- (void)bindViewModel:(THKViewModel *)viewModel;

@end
