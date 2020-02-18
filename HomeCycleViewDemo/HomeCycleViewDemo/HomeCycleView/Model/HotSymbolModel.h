//
//  HotSymbolModel.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/18.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotSymbolModelData :NSObject
@property (nonatomic , copy) NSString              * symbol;
@property (nonatomic , copy) NSString              * info;
@property (nonatomic , assign) NSInteger              eventType;
@property (nonatomic , assign) NSInteger              eventTarget;
@property (nonatomic , copy) NSString              * symbolName;
@property (nonatomic , assign) NSInteger              increase;
@property (nonatomic , copy) NSString              * price;

@end


@interface HotSymbolModel :NSObject
@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) NSArray <HotSymbolModelData *>              * data;

@end

NS_ASSUME_NONNULL_END
