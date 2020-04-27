//
//  RefreshFooter.h
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RefreshFooter : RefreshBaseView

@property (assign, nonatomic) int surplusCount;

- (void)noticeNoMoreData;

- (void)resetNoMoreData;

@end

NS_ASSUME_NONNULL_END
