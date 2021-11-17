//
//  ViewModel.h
//  HouseKeeper
//
//  Created by 熊熙 on 2020/8/31.
//  Copyright © 2020 binxun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const kModelIdKey;

FOUNDATION_EXTERN NSString *const kModelDataKey;

@interface THKViewModel : NSObject

- (instancetype)initWithModel:(id)model;

//viewModel动态设置model
- (void)bindWithModel:(id)model;

- (instancetype)initWithParams:(NSDictionary *)params;

@property (nonatomic, strong, readonly) id model;

//@property (nonatomic, copy) T8TObjBlock callbackBlock;

- (void)initialize;

/// will disappear signal
//@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

@end

NS_ASSUME_NONNULL_END
