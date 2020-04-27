//
//  RefreshConstant.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshConstant.h"

@implementation RefreshConstant

CGFloat const K_HEADER_HEIGHT = 120;

CGFloat const K_HEADER_MAXOFFY = K_HEADER_HEIGHT / 2.0;

CGFloat const K_FOOTER_HEIGHT = 120;

CGFloat const K_FOOTER_MAXOFFY = K_FOOTER_HEIGHT / 2.0;

NSString *const K_HEAD_NORMAL_TITLE =  @"下拉即可刷新";

NSString *const K_HEAD_PREPARE_TITLE = @"松开立即刷新";

NSString *const K_HEAD_START_TITLE = @"正在刷新数据";

NSString *const K_FOOT_NORMAL_TITLE = @"上拉即可加载更多";

NSString *const K_FOOT_PREPARE_TITLE = @"松开立即加载更多";

NSString *const K_FOOT_START_TITLE = @"正在加载更多数据";

NSString *const RefreshKeyPathContentOffset = @"contentOffset";

NSString *const RefreshKeyPathContentSize = @"contentSize";

NSString *const RefreshKeyPathContentInset = @"contentInset";


@end
