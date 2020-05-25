//
//  SkinMesureRecordCell.h
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkinMesureRecordCell : UITableViewCell

@property (strong, nonatomic) UIButton *scoreTagButtonLeft;
@property (strong, nonatomic) UIButton *scoreTagButtonRight;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (nonatomic,copy) void (^checkClick)(void);
@property (nonatomic,copy) void (^deleteClick)(void);

@end

NS_ASSUME_NONNULL_END
