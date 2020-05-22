//
//  SkinBandianCell.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "IGListBaseCell.h"
#import "SPMultipleSwitch.h"
NS_ASSUME_NONNULL_BEGIN

@interface SkinBandianCell : IGListBaseCell
@property (weak, nonatomic) IBOutlet SPMultipleSwitch *quebanSwitch;
@property (weak, nonatomic) IBOutlet SPMultipleSwitch *huanghebanSwith;
@property (weak, nonatomic) IBOutlet SPMultipleSwitch *zhiSwitch;
@property (weak, nonatomic) IBOutlet SPMultipleSwitch *otherSwith;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

NS_ASSUME_NONNULL_END
