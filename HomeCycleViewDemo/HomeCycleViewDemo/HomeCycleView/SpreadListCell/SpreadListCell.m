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
    _lineChartView.backColor = UIColor.clearColor;
    _polt = [[DVPlot alloc] init];
    _polt.lineColor = HEXCOLOR(0x2AD181);
    _polt.chartViewFill = NO;
    _polt.withPoint = YES;
    
    
    
}

- (void)setModel:(DiffPriceModelData *)model{
    _model = model;
    
    _contentlabel.text = [NSString stringWithFormat:@"币对：%@ \n最优价差：%@ 预计套利：%zd%%",model.symbolAndReference,model.diffPrice,model.interest];
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *prices = [NSMutableArray array];
    
    for (DiffPriceModelDataSymbolCurrentPriceVOS *price in model.symbolCurrentPriceVOS) {
        [titles addObject:price.exchange];
        [prices addObject:@(price.price.doubleValue)];
    }
    
    _lineChartView.pointGap = (_lineChartView.frame.size.width - 20)/ titles.count;
    _lineChartView.xAxisTitleArray = titles;
    _polt.pointArray = prices;
    [_lineChartView.plots removeAllObjects];
    [_lineChartView addPlot:_polt];
    [_lineChartView draw];
}

@end
