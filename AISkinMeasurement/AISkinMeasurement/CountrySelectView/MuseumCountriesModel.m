//
//  MuseumCountriesModel.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "MuseumCountriesModel.h"

@implementation MuseumCountriesModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"data": [MuseumCountriesModelData class]
    };
}
@end

@implementation MuseumCountriesModelData
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"hot": [MuseumCountriesModelDataAll class],
        @"all": [MuseumCountriesModelDataHot class]
    };
}

@end

@implementation MuseumCountriesModelDataAll


@end
@implementation MuseumCountriesModelDataHot


@end
