//
//  FaceChangePromptView.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/6/29.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceChangePromptView : UIView

@property (nonatomic,copy) void (^tapItem)(int index);

@end

NS_ASSUME_NONNULL_END
