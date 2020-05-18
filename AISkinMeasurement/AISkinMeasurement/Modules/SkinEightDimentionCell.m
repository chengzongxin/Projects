//
//  SkinEightDimentionCell.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "SkinEightDimentionCell.h"
#import "GBRadarChart.h"
#import "GBRadarChartDataItem.h"

@interface SkinEightDimentionCell ()

@property (strong, nonatomic) GBRadarChart *radarChart; //雷达图

@end

@implementation SkinEightDimentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat margin = 30;
    CGFloat width = UIScreen.mainScreen.bounds.size.width - margin * 2;
    GBRadarChart *radarChart = [[GBRadarChart alloc] initWithFrame:CGRectMake(margin, 50, width, width) items:@[] valueDivider:20];
    //    radarChart.isShowGraduation = YES;
    radarChart.labelStyle = GBRadarChartLabelStyleHorizontal;
    radarChart.webColor = [UIColor colorWithRed:205/255.0 green:207/255.0 blue:221/255.0 alpha:1];
    [radarChart strokeChart];
    [self addSubview:radarChart];
    _radarChart = radarChart;
}

- (void)setModel:(id)model{
    [super setModel:model];
    
    [self drawRadarChart];
}


- (void)drawRadarChart {
    NSMutableArray *items = [NSMutableArray array];
    NSArray *values = @[@100,@50,@70,@30,@50,@40,@45,@88];
    NSArray *text = @[@"苹果",@"香蕉",@"花生",@"橙子",@"车子",@"奶子",@"房子",@"xx子"];
    for (int i = 0; i < values.count; i++) {
        
        NSString *score = [values[i] stringValue];
        NSString *content = text[i];
        NSString *str = [NSString stringWithFormat:@"%@分\n%@",score,content];
        NSRange range = [str rangeOfString:score];
        
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:78/255.0 green:86/255.0 blue:109/255.0 alpha:1.0]};
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:attr];
        [string addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} range:range];
        GBRadarChartDataItem *item = [GBRadarChartDataItem dataItemWithValue:[values[i] floatValue] text:string];
        [items addObject:item];
    }
    
    [_radarChart updateChartWithChartData:items];
}

@end
