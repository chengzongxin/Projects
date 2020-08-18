//
//  CountrySelectView.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MuseumCountriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountrySelectView : UIView

- (void)show;
- (void)dismiss;

@property (strong, nonatomic) MuseumCountriesModel* data;

@end

NS_ASSUME_NONNULL_END
