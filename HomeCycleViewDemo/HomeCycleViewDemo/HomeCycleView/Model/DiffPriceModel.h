//
//  DiffPriceModel.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/18.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@interface DiffPriceModel : NSObject
//
//@end

@interface DiffPriceModelDataSymbolCurrentPriceVOS :NSObject
@property (nonatomic , copy) NSString              * exchange;
@property (nonatomic , copy) NSString              * price;

@end


@interface DiffPriceModelData :NSObject
@property (nonatomic , copy) NSString              * symbolAndReference;
@property (nonatomic , copy) NSString              * diffPrice;
@property (nonatomic , assign) NSInteger              interest;
@property (nonatomic , strong) NSArray <DiffPriceModelDataSymbolCurrentPriceVOS *>              * symbolCurrentPriceVOS;

@end


@interface DiffPriceModel :NSObject
@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) NSArray <DiffPriceModelData *>              * data;

@end

NS_ASSUME_NONNULL_END
