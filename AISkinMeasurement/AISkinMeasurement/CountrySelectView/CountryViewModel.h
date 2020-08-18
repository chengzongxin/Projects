//
//  CountryViewModel.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MuseumCountriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryViewModel : NSObject
+ (void)getMuseumCountries:(void(^)(id MuseumCountriesModel))success
                      fail:(void(^)(NSString *message))fail;
@end

NS_ASSUME_NONNULL_END
