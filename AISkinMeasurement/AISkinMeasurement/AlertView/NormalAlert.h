//
//  NormalAlert.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalAlert : UIView

@property (nonatomic,copy) void (^tapItem)(int index);

@end

NS_ASSUME_NONNULL_END
