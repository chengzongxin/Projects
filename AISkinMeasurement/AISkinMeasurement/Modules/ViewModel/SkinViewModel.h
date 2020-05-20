//
//  SkinViewModel.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/20.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkinViewModel : NSObject

+ (void)analysisInfoQuery:(NSString *)deviceNo
                 recordNo:(NSString *)recordNo
                  success:(void(^)(id data))success
                     fail:(void(^)(NSString *message))fail;

+ (void)applyAnalysisCommand:(UIImage *)images
                    deviceNo:(NSString *)deviceNo
       analysisPersonnelType:(NSString *)analysisPersonnelType
                     success:(void(^)(id data))success
                        fail:(void(^)(NSString *message))fail;
@end

NS_ASSUME_NONNULL_END
