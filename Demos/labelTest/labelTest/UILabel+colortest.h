//
//  UILabel+colortest.h
//  labelTest
//
//  Created by Joe.cheng on 2021/3/1.
//

#import <UIKit/UIKit.h>

typedef UILabel *(^lableColorblock)(id value);

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (colortest)
@property (nonatomic, readonly) lableColorblock textcolor1;
@end

NS_ASSUME_NONNULL_END
