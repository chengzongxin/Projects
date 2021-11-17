//
//  BeCollectThumbupView.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/2.
//

#import <UIKit/UIKit.h>
#import "Define_Block.h"

NS_ASSUME_NONNULL_BEGIN

@interface BeCollectThumbupView : UIView

@property (nonatomic, copy) T8TBtnBlock clickBlock;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *beThumbupLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *beCollectLabel;


@end

NS_ASSUME_NONNULL_END
