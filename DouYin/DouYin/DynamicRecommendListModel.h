//
//  DynamicRecommendListModel.h
//  Matafy
//
//  Created by Joe on 2019/6/19.
//  Copyright © 2019 com.upintech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicListModel.h"
NS_ASSUME_NONNULL_BEGIN
//@class DynamicRecommendListModelData;
//@class DynamicRecommendListModelDataMediaContentList;

@interface DynamicRecommendListModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSArray <DynamicListModelDataList *>* data;
@property (nonatomic, strong) NSString * message;
@end


//@interface DynamicRecommendListModelData : NSObject
//
//@property (nonatomic, strong) NSString * avatar;
//@property (nonatomic, strong) NSObject * city;
//@property (nonatomic, strong) NSObject * collectNum;
//@property (nonatomic, assign) NSInteger commentNum;
//@property (nonatomic, strong) NSString * content;
//@property (nonatomic, strong) NSString * createTime;
//@property (nonatomic, strong) NSObject * dynamicCover;
//@property (nonatomic, strong) NSString * dynamicType;
//@property (nonatomic, strong) NSString * from;
//@property (nonatomic, strong) NSString * fromCn;
//@property (nonatomic, assign) BOOL hadCollect;
//@property (nonatomic, assign) BOOL hadFollow;
//@property (nonatomic, assign) BOOL hadThumbUp;
//@property (nonatomic, strong) NSObject * hotelId;
//@property (nonatomic, strong) NSObject * hotelName;
//@property (nonatomic, strong) NSString * id;
//@property (nonatomic, strong) NSArray <NSString *>* labels;
//@property (nonatomic, strong) NSArray <DynamicRecommendListModelDataMediaContentList *>* mediaContentList;
//@property (nonatomic, strong) NSString * nickname;
//@property (nonatomic, strong) NSObject * spotAddress;
//@property (nonatomic, strong) NSObject * spotId;
//@property (nonatomic, strong) NSObject * spotName;
//@property (nonatomic, strong) NSString * status;
//@property (nonatomic, assign) NSInteger thumbUpNum;
//@property (nonatomic, strong) NSString * title;
//@property (nonatomic, strong) NSString * userId;
//@end


//@interface DynamicRecommendListModelDataMediaContentList : NSObject
//
//@property (nonatomic, assign) NSInteger height;
//@property (nonatomic, strong) NSString * mediaType;
//@property (nonatomic, assign) NSInteger order;
//@property (nonatomic, strong) NSString * url;
//@property (nonatomic, assign) NSInteger width;
//@end

NS_ASSUME_NONNULL_END
