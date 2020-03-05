//
//  ShadowSectionCell.h
//  ShadowTableView
//
//  Created by Joe on 2020/3/5.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShadowCellShadowView :UIView

@property (nonatomic, strong) CAShapeLayer *shadowLayer;

@property (nonatomic, strong) CALayer *separatorLine;

@end

@interface ShadowSectionCell : UITableViewCell

@property (nonatomic, strong) ShadowCellShadowView *bgView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
