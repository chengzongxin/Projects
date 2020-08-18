//
//  MuseumCountriesModel.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface MuseumCountriesModelDataHot :NSObject
@property (nonatomic , copy) NSString              * cuntryname;
@property (nonatomic , copy) NSString              * firstletter;
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , assign) NSInteger              is_hot;
@property (nonatomic , assign) NSInteger              sort_by;
@property (nonatomic , copy) NSString              * countrypinyin;

@end


@interface MuseumCountriesModelDataAll :NSObject
@property (nonatomic , copy) NSString              * cuntryname;
@property (nonatomic , copy) NSString              * firstletter;
@property (nonatomic , copy) NSString              * _id;
@property (nonatomic , assign) NSInteger              is_hot;
@property (nonatomic , assign) NSInteger              sort_by;
@property (nonatomic , copy) NSString              * countrypinyin;

@end


@interface MuseumCountriesModelData :NSObject
@property (nonatomic , strong) NSArray <MuseumCountriesModelDataHot *>              * hot;
@property (nonatomic , strong) NSArray <MuseumCountriesModelDataAll *>              * all;

@end


@interface MuseumCountriesModel :NSObject
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) MuseumCountriesModelData              * data;
@property (nonatomic , assign) NSInteger              code;

@end

NS_ASSUME_NONNULL_END
