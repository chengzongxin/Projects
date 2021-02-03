//
//  THKIdentityIconView.h
//  HouseKeeper
//  身份标识View
//  Created by ben.gan on 2020/8/13.
//  Copyright © 2020 binxun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    THKIdentityIconViewStyle_None,      //无
    THKIdentityIconViewStyle_Author,    //作者
    THKIdentityIconViewStyle_1,         //家居达人
    THKIdentityIconViewStyle_2,         //官方认证
    THKIdentityIconViewStyle_3,         //设计机构
    THKIdentityIconViewStyle_4,         //品牌商家
    THKIdentityIconViewStyle_5,         //装修公司
} THKIdentityIconViewStyle;

NS_ASSUME_NONNULL_BEGIN

@interface THKIdentityIconView : UIView

@property (nonatomic, assign) THKIdentityIconViewStyle style;

@end

NS_ASSUME_NONNULL_END
