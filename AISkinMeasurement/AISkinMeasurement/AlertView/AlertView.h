//
//  MenuPopView.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnAction)(NSInteger index);
typedef void (^AlertViewConfirmHandle)(void);
typedef void (^AlertViewCancelHandle)(void);

@interface AlertView : UIView
@property (nonatomic, strong) UIView        *container;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *subtitleLabel;
@property (nonatomic, strong) UIButton      *confirm;
@property (nonatomic, strong) UIButton      *cancel;
@property (nonatomic, strong) OnAction      onAction;

- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
                      confirm:(NSString *)confirm
                       cancel:(NSString *)cancel;

- (instancetype)initWithTitle:(NSString *)title
                      confirm:(NSString *)confirm
                       cancel:(NSString *)cancel;

- (void)show;
- (void)dismiss;

+ (void)showWithTitle:(NSString *)title
             subtitle:(NSString *)subtitle
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)confirmHandle
         cancelHandle:(AlertViewCancelHandle)cancelHandle;

+ (void)showWithTitle:(NSString *)title
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)confirmHandle
         cancelHandle:(AlertViewCancelHandle)cancelHandle;

+ (void)showWithTitle:(NSString *)title
              confirm:(NSString *)confirm
               cancel:(NSString *)cancel
        confirmHandle:(AlertViewConfirmHandle)handle;


@end
