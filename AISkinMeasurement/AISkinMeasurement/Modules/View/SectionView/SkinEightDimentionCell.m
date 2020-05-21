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
    
    
    [_roughSwithButton initialWithItems:@[@"光滑",@"一般",@"粗糙"]];
    _roughSwithButton.titleFont = [UIFont boldSystemFontOfSize:12];
    _roughSwithButton.frame = CGRectMake(15, 180, 192, 24);
    _roughSwithButton.backgroundColor = [UIColor colorWithRed:246/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    _roughSwithButton.selectedTitleColor = UIColor.whiteColor;
    _roughSwithButton.titleColor = [UIColor colorWithRed:121/255.0 green:132/255.0 blue:156/255.0 alpha:1.0];
    _roughSwithButton.contentInset = 0;
    _roughSwithButton.spacing = 10;
    _roughSwithButton.trackerColor = [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0];
    [_roughSwithButton addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)switchAction3:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
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
