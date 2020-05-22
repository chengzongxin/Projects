//
//  SkinOverviewCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinOverviewCell.h"
#import "UIKitConvenient.h"

@interface SkinOverviewCell ()

@property (strong, nonatomic) UIButton *scoreTagButtonLeft;
@property (strong, nonatomic) UIButton *scoreTagButtonRight;

@end

@implementation SkinOverviewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CGFloat progressH = 88;
    CGFloat lineWidth = 7;
    
    _circleProgress = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 88 - 25, 20, progressH, progressH) pathBackColor:rgba(234, 235, 246, 1) pathFillColor:rgba(0, 195, 206, 1) startAngle:0 strokeWidth:lineWidth];
    _circleProgress.startAngle = 135;
    _circleProgress.reduceAngle = 90;
    _circleProgress.increaseFromLast = YES;
    // 创建原点图片
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineWidth * 3, lineWidth * 3)];
    pointView.backgroundColor = rgba(0, 195, 206, 1);
    pointView.layer.cornerRadius = lineWidth * 3/2.0;
    pointView.layer.masksToBounds = YES;
    pointView.clipsToBounds = YES;
    UIView *pointCircleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, lineWidth)];
    pointCircleView.backgroundColor = rgba(234, 235, 246, 1);
    pointCircleView.layer.cornerRadius = lineWidth/2.0;
    pointCircleView.center = pointView.center;
    [pointView addSubview:pointCircleView];
    UIImage *pointImage = [pointView convertToImage];

    _circleProgress.pointImage.image = pointImage;
    [self addSubview:self.circleProgress];
    
    _scoreTagButtonLeft = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_circleProgress.frame),CGRectGetMaxY(_circleProgress.frame) - progressH/6.0 ,CGRectGetWidth(_circleProgress.frame),18)];
    _scoreTagButtonLeft.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    _scoreTagButtonLeft.layer.cornerRadius = 4;
    _scoreTagButtonLeft.layer.borderWidth = 0.5;
    _scoreTagButtonLeft.layer.masksToBounds = YES;
    _scoreTagButtonLeft.layer.borderColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0].CGColor;
    [_scoreTagButtonLeft setTitleColor:rgba(0, 195, 206, 1) forState:UIControlStateNormal];
    [_scoreTagButtonLeft setTitle:@"肌肤良好指数" forState:UIControlStateNormal];
    _scoreTagButtonLeft.titleLabel.font = [UIFont systemFontOfSize:9];
    _scoreTagButtonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _scoreTagButtonLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    [self addSubview:_scoreTagButtonLeft];
    
    _scoreTagButtonRight = [[UIButton alloc] initWithFrame:CGRectMake(_scoreTagButtonLeft.bounds.size.width - 29,0,29,18)];
    _scoreTagButtonRight.backgroundColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
//    _scoreTagButtonRight.layer.cornerRadius = 4;
    [_scoreTagButtonRight setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_scoreTagButtonRight setTitle:@"良好" forState:UIControlStateNormal];
    _scoreTagButtonRight.titleLabel.font = [UIFont systemFontOfSize:9];
    [_scoreTagButtonLeft addSubview:_scoreTagButtonRight];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setGradientColors:@[rgba(255, 255, 255, 1),rgba(233, 251, 251, 1)] gradientFrame:self.bounds startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) gradientCorner:0 locations:@[@0,@1]];
}

- (void)setModel:(id)model{
    [super setModel:model];
    
    NSLog(@"%@",model);
    int value = [model intValue];
    _circleProgress.progress = value/100.0;
    
    NSString *modelStr = @(value).stringValue;
    NSString *scoreStr = modelStr;
    NSString *percentStr = [modelStr stringByAppendingString:@"%"];
    NSString *allStr = [NSString stringWithFormat:@"本次测试得分%@分，打败了%@的测试用户",scoreStr,percentStr];
    NSRange scoreRange = [allStr rangeOfString:scoreStr];
    NSRange percentRange = [allStr rangeOfString:percentStr];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allStr attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor colorWithRed:19/255.0 green:27/255.0 blue:54/255.0 alpha:1.0]}];

    [string addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                            NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:73/255.0 blue:52/255.0 alpha:1.0]} range:scoreRange];

    [string addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
    NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:73/255.0 blue:52/255.0 alpha:1.0]} range:percentRange];

    _contentLabel.attributedText = string;
}




@end
