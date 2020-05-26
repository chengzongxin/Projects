//
//  SkinLabel.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 使用约束布局时,必须指定width,之后会自动更新width约束
 使用frame布局,会自适应更新width
 */

@interface CombinationLabel : UIView

- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText;

@end

NS_ASSUME_NONNULL_END
