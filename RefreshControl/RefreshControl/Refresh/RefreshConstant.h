//
//  RefreshConstant.h
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefreshConstant : NSObject

FOUNDATION_EXTERN CGFloat const K_HEADER_HEIGHT;//头部刷新控件高度

FOUNDATION_EXTERN CGFloat const K_HEADER_MAXOFFY;//刷新临界值

FOUNDATION_EXTERN CGFloat const K_FOOTER_HEIGHT;

FOUNDATION_EXTERN CGFloat const K_FOOTER_MAXOFFY;

FOUNDATION_EXPORT NSString *const K_HEAD_NORMAL_TITLE;

FOUNDATION_EXPORT NSString *const K_HEAD_PREPARE_TITLE;

FOUNDATION_EXPORT NSString *const K_HEAD_START_TITLE;

FOUNDATION_EXPORT NSString *const K_FOOT_NORMAL_TITLE;

FOUNDATION_EXPORT NSString *const K_FOOT_PREPARE_TITLE;

FOUNDATION_EXPORT NSString *const K_FOOT_START_TITLE;

FOUNDATION_EXPORT NSString *const RefreshKeyPathContentOffset;

FOUNDATION_EXPORT NSString *const RefreshKeyPathContentSize;

FOUNDATION_EXPORT NSString *const RefreshKeyPathContentInset;

@end

NS_ASSUME_NONNULL_END
