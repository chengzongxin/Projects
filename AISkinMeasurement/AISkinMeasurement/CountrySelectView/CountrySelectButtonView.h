//
//  CountrySelectButtonView.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/8/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountrySelectButtonView : UIView
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
+ (instancetype)xibView;

@property (nonatomic,copy) void (^tapItem)(int index);

@end

NS_ASSUME_NONNULL_END
