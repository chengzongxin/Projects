//
//  ExponentModel.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/18.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExponentModelData :NSObject
@property (nonatomic , copy) NSString              * symbolCode;
@property (nonatomic , copy) NSString              * symbolName;
@property (nonatomic , copy) NSString              * cnyPrice;
@property (nonatomic , copy) NSString              * usdPrice;
@property (nonatomic , copy) NSString              * krwPrice;
@property (nonatomic , copy) NSString              * jpyPrice;
@property (nonatomic , assign) NSInteger              increase;

@end


@interface ExponentModel :NSObject
@property (nonatomic , assign) NSInteger              code;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , strong) NSArray <ExponentModelData *>              * data;

@end

NS_ASSUME_NONNULL_END
