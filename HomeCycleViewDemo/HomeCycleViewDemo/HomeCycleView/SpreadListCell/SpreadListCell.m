//
//  SpreadListCell.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "SpreadListCell.h"
#import "DVLineChartView.h"

/** 十六进制颜色 Hex */
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SpreadListCell ()<DVLineChartViewDelegate>

@property (nonatomic,strong) DVLineChartView *lineChartView;

@property (nonatomic,strong) DVPlot *polt;

@end

@implementation SpreadListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 柱状图
    _lineChartView = [[DVLineChartView alloc] initWithFrame:CGRectMake(10, 70, UIScreen.mainScreen.bounds.size.width - 34, 110)];
    [self.contentView addSubview:_lineChartView];
    _lineChartView.yAxisViewWidth = 5;
    _lineChartView.numberOfYAxisElements = 1;
//    _lineChartView.delegate = self;
    _lineChartView.pointUserInteractionEnabled = NO;
    _lineChartView.pointGap = 65;
    
    _lineChartView.showSeparate = NO;
    _lineChartView.separateColor = [UIColor clearColor];
    _lineChartView.textColor = HEXCOLOR(0xCCCCCC);
    _lineChartView.pointTopLabelColor = HEXCOLOR(0x666666);
    _lineChartView.axisColor = [UIColor clearColor];
    _lineChartView.yAxisMaxValue = 100;
    _lineChartView.isScal = NO;
    _polt = [[DVPlot alloc] init];
    _polt.lineColor = HEXCOLOR(0x2AD181);
    _polt.chartViewFill = NO;
    _polt.withPoint = YES;
    
    
    
}

- (void)setData:(id)data{
    _data = data;
    
    NSArray *data1 = data[0];
    
    NSArray *data2 = data[1];
    
    // filldata
//    _lineChartView.xAxisTitleArray = @[@"12",@"12",@"23",@"2222",@"111"];
//    _polt.pointArray = @[@1,@2,@3,@4,@5];
    _lineChartView.pointGap = (_lineChartView.frame.size.width - 20)/ data2.count;
    _lineChartView.xAxisTitleArray = data1;
    _polt.pointArray = data2;
    [_lineChartView.plots removeAllObjects];
    [_lineChartView addPlot:_polt];
    [_lineChartView draw];
}

@end
