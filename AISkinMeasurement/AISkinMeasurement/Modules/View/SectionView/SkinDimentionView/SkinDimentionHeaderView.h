//
//  SkinDimentionHeaderView.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/21.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "IGListBaseReusableView.h"
#import "SPMultipleSwitch.h"
NS_ASSUME_NONNULL_BEGIN

@interface SkinDimentionHeaderView : IGListBaseReusableView
@property (weak, nonatomic) IBOutlet SPMultipleSwitch *switchButton;

@end

NS_ASSUME_NONNULL_END
