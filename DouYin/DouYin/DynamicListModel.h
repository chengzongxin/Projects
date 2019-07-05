//
//  DynamicListModel.h
//  Matafy
//
//  Created by Jason on 2018/11/8.
//  Copyright © 2018 com.upintech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DynamicListModelData;
@class DynamicListModelDataList;
@class DynamicListModelDataListMediaContentList;

@interface DynamicListModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) DynamicListModelData * data;
@property (nonatomic,strong) DynamicListModelDataList *list;
@property (nonatomic,strong) NSMutableArray *listData;

@property (nonatomic, strong) NSString * message;
@end

@interface DynamicListModelData : NSObject

@property (nonatomic, assign) NSInteger endRow;
@property (nonatomic, assign) NSInteger firstPage;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) BOOL hasPreviousPage;
@property (nonatomic, assign) BOOL isFirstPage;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, assign) NSInteger lastPage;
@property (nonatomic, strong) NSArray <DynamicListModelDataList *>* list;
@property (nonatomic, assign) NSInteger navigateFirstPage;
@property (nonatomic, assign) NSInteger navigateLastPage;
@property (nonatomic, assign) NSInteger navigatePages;
@property (nonatomic, strong) NSArray * navigatepageNums;
@property (nonatomic, assign) NSInteger nextPage;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger prePage;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger startRow;
@property (nonatomic, assign) NSInteger total;
@end


@interface DynamicListModelDataList : NSObject

@property (nonatomic, strong) NSObject * auditTime;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, assign) NSInteger collectNum;
@property (nonatomic, assign) NSInteger commentNum;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * dynamicType;
@property (nonatomic,copy) NSString *dynamicCover; // 动态图
@property (nonatomic, assign) BOOL hadCollect;
@property (nonatomic, assign) BOOL hadThumbUp;
@property (nonatomic, assign) BOOL hadFollow;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSArray <DynamicListModelDataListMediaContentList *>* mediaContentList;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSObject * remark;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, assign) NSInteger thumbUpNum;
@property (nonatomic, strong) NSString * thumbUpNumStr;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) float weight;
@property (nonatomic, strong) NSString *hotelId;
@property (nonatomic, strong) NSString *hotelName;
@property (nonatomic, strong) NSArray <NSString *>* labels;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *fromCn;
@property (nonatomic,copy) NSString *spotId;
@property (nonatomic,copy) NSString *spotName;
@property (nonatomic,copy) NSString *spotAddress;
@property (nonatomic,copy) NSString * city;
@end

@interface DynamicListModelDataListMediaContentList : NSObject

@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger dynamicId;
@property (nonatomic, assign) float height;
@property (nonatomic, copy)   NSString *id;
@property (nonatomic, strong) NSString * mediaType;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) float width;

@end

NS_ASSUME_NONNULL_END
