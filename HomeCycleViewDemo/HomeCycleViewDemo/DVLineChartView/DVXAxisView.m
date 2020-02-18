//
//  DVXAxisView.m
//  DVLineChart
//
//  Created by Fire on 15/10/16.
//  Copyright © 2015年 DuoLaiDian. All rights reserved.
//

#import "DVXAxisView.h"
#import "DVPlot.h"
#import "UIView+Layout.h"
#define LeftMargin 14
// 防止划线在最左侧
#define firstOffsetX  2
// 第一个点直径
#define dot_1R 16
// 其他店直径
#define dot_2R 10
@interface DVXAxisView ()
/**
 *  图表顶部留白区域
 */
@property (assign, nonatomic) CGFloat topMargin;
/**
 *  记录图表区域的高度
 */
@property (assign, nonatomic) CGFloat chartHeight;
/**
 *  记录坐标轴Label的高度
 */
@property (assign, nonatomic) CGFloat textHeight;
/**
 *  存放坐标轴的label（底部的）
 */
@property (strong, nonatomic) NSMutableArray *titleLabelArray;
/**
 *  记录坐标轴的第一个Label
 */
@property (strong, nonatomic) UILabel *firstLabel;
/**
 *  记录点按钮的集合
 */
@property (strong, nonatomic) NSMutableArray *buttonPointArray;
/**
 *  选中的点
 */
@property (strong, nonatomic) UIButton *selectedPoint;

@property (strong, nonatomic) NSMutableArray *pointButtonArray;
@end

@implementation DVXAxisView

- (NSMutableArray *)pointButtonArray {
    
    if (_pointButtonArray == nil) {
        _pointButtonArray = [NSMutableArray array];
    }
    return _pointButtonArray;
}

- (NSMutableArray *)titleLabelArray {
    if (_titleLabelArray == nil) {
        _titleLabelArray = [NSMutableArray array];
    }
    return _titleLabelArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.textFont = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setPointGap:(CGFloat)pointGap {
    _pointGap = pointGap;
    
    [self draw];
    
}

- (NSMutableArray *)buttonPointArray {
	
	if (_buttonPointArray == nil) {
		_buttonPointArray = [NSMutableArray array];
	}
	return _buttonPointArray;
}

- (void)draw {
    
    self.backgroundColor = self.backColor;
    // 移除先前存在的所有视图
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    // 移除数组内所有的Label元素
    [self.titleLabelArray removeAllObjects];
    [self.pointButtonArray removeAllObjects];
    
    // 添加坐标轴Label
    for (int i = 0; i < self.xAxisTitleArray.count; i++) {
        NSString *title = self.xAxisTitleArray[i];
//        if([title includeChinese] && title.length > 3)
//        {
//            title = [NSString stringWithFormat:@"%@...",[title substringToIndex:2]];
//        }
//
//        if (![title includeChinese] && title.length > 6) {
//             title = [NSString stringWithFormat:@"%@...",[title substringToIndex:5]];
//        }
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.font = self.textFont;
        label.textColor = self.textColor;
        
        NSDictionary *attr = @{NSFontAttributeName : self.textFont};
        CGSize labelSize = [title sizeWithAttributes:attr];
        
        label.x = (i) * self.pointGap + LeftMargin - labelSize.width / 2;
        label.y = self.height - labelSize.height;
        label.width = labelSize.width;
        label.height = labelSize.height;
        
        if (i == 0) {
            self.firstLabel = label;
        }
        
        [self.titleLabelArray addObject:label];
        [self addSubview:label];
    }
    
    // 添加坐标轴
    NSDictionary *attribute = @{NSFontAttributeName : self.textFont};
    CGSize textSize = [@"x" sizeWithAttributes:attribute];
    
    self.textHeight = textSize.height;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = self.axisColor;
    view.height = 1;
    view.width = self.width + 200;
    view.x = -200;
    view.y = self.height - textSize.height - self.xAxisTextGap;
    [self addSubview:view];
    
    // 计算横向分割线位置
    self.topMargin = 25;
    self.chartHeight = self.height - textSize.height - self.xAxisTextGap - self.topMargin;
    CGFloat separateHeight = 1;
    CGFloat separateMargin = (self.height - self.topMargin - textSize.height - self.xAxisTextGap - self.numberOfYAxisElements * separateHeight) / self.numberOfYAxisElements;
    
    // 画横向分割线
    if (self.isShowSeparate) {
        
        for (int i = 0; i < self.numberOfYAxisElements; i++) {
            
            UIView *separate = [[UIView alloc] init];
            separate.x = 0;
            separate.width = self.width;
            separate.height = separateHeight;
            separate.y = view.y - (i + 1) * (separateMargin + separate.height);
            separate.backgroundColor = self.separateColor;
            [self addSubview:separate];
        }
    }
    
    
    // 如果Label的文字有重叠，那么隐藏
    for (int i = 0; i < self.titleLabelArray.count; i++) {
        
        UILabel *label = self.titleLabelArray[i];
        
        CGFloat maxX = CGRectGetMaxX(self.firstLabel.frame);
        
        if (self.isShowTailAndHead == NO) {
            if (i != 0) {
                if ((maxX + 3) > label.x) {
                    label.hidden = YES;
                }else{
                    label.hidden = NO;
                    self.firstLabel = label;
                }
            }else {
                if (self.firstLabel.x < 0) {
                    self.firstLabel.x = 0;
                }
            }
        }else{
            
            if (i > 0 && i < self.titleLabelArray.count - 1) {
                
                label.hidden = YES;
                
            }else if(i == 0){
            
                if (self.firstLabel.x < 0) {
                    self.firstLabel.x = 0;
                }
            
            }else{
                
                if (CGRectGetMaxX(label.frame) > self.width) {
                    
                    label.x = self.width - label.width;
                }
            }
        }
    }
    
    
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {

    for (DVPlot *plot in self.plots) {
		
		[self drawLineInRect:rect withPlot:plot isPoint:NO];
		
		if (plot.withPoint) {
			
			[self drawLineInRect:rect withPlot:plot isPoint:YES];
			
		}
    }
}

- (void)drawLineInRect:(CGRect)rect withPlot:(DVPlot *)plot isPoint:(BOOL)isPoint {
    
    // 精度问题,先放大10000倍
    int scale = 10000;
    NSMutableArray *scaleValues = [NSMutableArray array];
    for (NSNumber *value in plot.pointArray) {
        NSNumber *scaleValue = @(value.doubleValue * scale);
        [scaleValues addObject:scaleValue];
    }
    
    if (isPoint) {  // 画点
        
        for (int i = 0; i < plot.pointArray.count; i++) {
            
            NSNumber *value = scaleValues[i];
//            NSString *title = [self decimalwithFormat:@"0.00" floatV:value.floatValue];
            NSString *title = [NSString stringWithFormat:@"%g",value.doubleValue / scale];

			
			// 判断title的值，整数或者小数
			if (![self isPureFloat:title]) {
				title = [NSString stringWithFormat:@"%.0f", title.floatValue];
			}
			
			
			if (value.floatValue < 0) {
				value = @(0);
			}
			
            
            // 最大
            NSNumber *max =   scaleValues.lastObject;
            NSInteger maxPrice =ceil (max.doubleValue) ;
            // 最小
            NSNumber *min =   scaleValues.firstObject;
            NSInteger minPrice = ceil (min.doubleValue) ;
            //大小差价
            NSInteger amplitudePrice = maxPrice - minPrice;
            NSInteger valueX =  value.integerValue;
            double a =(double)80 / (double)amplitudePrice;
            double b = a * (valueX - minPrice);
            double c = b + 20;
            
            if(maxPrice - minPrice == 0)
            {
                c = 20;
            }
            
            CGPoint center = CGPointMake((i)*self.pointGap + LeftMargin, self.chartHeight - c/self.yAxisMaxValue * self.chartHeight + self.topMargin);
			
			if (self.yAxisMaxValue * self.chartHeight == 0) {
				center = CGPointMake((i+1)*self.pointGap, self.chartHeight + self.topMargin);
			}
			
            // 添加point处的Label
            if (self.isShowPointLabel) {
                
                [self addLabelWithTitle:title atLocation:center andTag:i];
                
            }
			
			UIButton *button = [[UIButton alloc] init];
			button.tag = i;
			button.center = center;
			button.layer.masksToBounds = YES;
			button.userInteractionEnabled = self.isPointUserInteractionEnabled;
			[button addTarget:self action:@selector(pointDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            if(i == 0 )
            {
                UIImage *image = [UIImage imageNamed:@"圆2"];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                button.size = CGSizeMake(dot_1R, dot_1R);
                button.layer.cornerRadius = dot_1R * 0.5;
            }else
            {
                UIImage *image = [UIImage imageNamed:@"圆点"];
                [button setBackgroundImage:image forState:UIControlStateNormal];
                button.size = CGSizeMake(dot_2R, dot_2R);
                button.layer.cornerRadius = dot_2R * 0.5;
            }
            [self.pointButtonArray addObject:button];
            button.backgroundColor = [UIColor clearColor];
			if (button.userInteractionEnabled) {
				if (i == 0) {
					[self pointDidClicked:button];
				}
			}
			
			[self addSubview:button];
        }
        
    }else{
        
        if (plot.isChartViewFill) { // 画线，空白处填充
            // 最大
            NSNumber *max =   scaleValues.lastObject;
            NSInteger maxPrice =ceil(max.doubleValue);
            // 最小
            NSNumber *min =   scaleValues.firstObject;
            NSInteger minPrice = ceil(min.doubleValue) ;
            //大小差价
            NSInteger amplitudePrice = maxPrice - minPrice;
            NSInteger valueX = min.integerValue ;
            double a =(double)80 / (double)amplitudePrice;
            double b = a * (valueX - minPrice);
            double c = b + 20;
            
            if(maxPrice - minPrice == 0)
            {
                c = 20;
            }
            
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            
            UIBezierPath *path = [[UIBezierPath alloc] init];
            
            CGPoint start = CGPointMake(LeftMargin+(LeftMargin * 0.5), self.chartHeight - c/self.yAxisMaxValue * self.chartHeight + self.topMargin+ dot_2R * 0.5);
            
            [path moveToPoint:start];
            
            for (int i = 0; i < plot.pointArray.count; i++) {
                
                NSNumber *value = scaleValues[i];
				
				if (value.floatValue < 0) {
					value = @(0);
				}
				
                CGPoint center = CGPointMake((i+1)*self.pointGap+LeftMargin, self.chartHeight - c/self.yAxisMaxValue * self.chartHeight + self.topMargin+ dot_2R * 0.5);
                
				
				if (self.yAxisMaxValue * self.chartHeight == 0) {
					center = CGPointMake((i+1)*self.pointGap, self.chartHeight + self.topMargin);
				}
				
                [path addLineToPoint:center];
                
            }
            
            CGPoint end = CGPointMake(plot.pointArray.count*self.pointGap, self.height - self.xAxisTextGap - self.textHeight);
            
            [path addLineToPoint:end];
            
//            [[plot.lineColor colorWithAlphaComponent:0.35] set];
			[plot.lineColor set];
            // 将路径添加到图形上下文
            CGContextAddPath(ctx, path.CGPath);
            // 渲染
            CGContextFillPath(ctx);
            
        }else{  // 画线，只有线，没有填充色
            
            
            NSMutableArray *pointArray = [NSMutableArray array];
            
            // 最大
            NSNumber *max =   scaleValues.lastObject;
            NSInteger maxPrice = ceil(max.doubleValue) ;
            // 最小
            NSNumber *min =   scaleValues.firstObject;
            NSInteger minPrice = ceil(min.doubleValue);
            //大小差价
            NSInteger amplitudePrice = maxPrice - minPrice;
            NSInteger valueX =  min.integerValue;
            double a =(double)80 / (double)amplitudePrice;
            double b = a * (valueX - minPrice);
            double c = b + 20;
            
            if(maxPrice - minPrice == 0)
            {
                c = 20;
            }
            
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            UIBezierPath *path = [[UIBezierPath alloc] init];
            CGPoint start = CGPointMake(LeftMargin+(LeftMargin * 0.5), self.chartHeight - c/self.yAxisMaxValue * self.chartHeight + self.topMargin+ dot_1R * 0.5);
            
            [path moveToPoint:start];
            [pointArray addObject:@(start)];
            for (int i = 0; i < plot.pointArray.count; i++) {
                
                if (i < plot.pointArray.count - 1) {
                    NSNumber *value = scaleValues[i+1];
                    // 最大
                    NSNumber *max =   scaleValues.lastObject;
                    NSInteger maxPrice =ceil (max.doubleValue);
                    // 最小
                    NSNumber *min =   scaleValues.firstObject;
                    NSInteger minPrice = ceil (min.doubleValue);
                    //大小差价
                    NSInteger amplitudePrice = maxPrice - minPrice;
                    NSInteger valueX =  value.integerValue;
                    double a =(double)80 / (double)amplitudePrice;
                    double b = a * (valueX - minPrice);
                    double c = b + 20;
                    
                    if(maxPrice - minPrice == 0)
                    {
                        c = 20;
                    }

                    CGPoint center = CGPointMake((i+1)*self.pointGap+LeftMargin, self.chartHeight - c/self.yAxisMaxValue * self.chartHeight + self.topMargin+ dot_2R * 0.5);
                    
//                    NSLog(@"point =  %@",NSStringFromCGPoint(center));
					
					if (self.yAxisMaxValue * self.chartHeight == 0) {
						center = CGPointMake((i+1)*self.pointGap, self.chartHeight + self.topMargin);
					}
                    [path addLineToPoint:center];
                    [pointArray addObject:@(center)];
                    
                }
                
            }
            
            [self drawLinearGradient:rect pointArray:pointArray];
            
            [[plot.lineColor colorWithAlphaComponent:0.7] set];
            // 将路径添加到图形上下文
            CGContextAddPath(ctx, path.CGPath);
            CGContextSetLineWidth(ctx, 3);
            // 渲染
            CGContextStrokePath(ctx);
        }
    }
    
}

//线性渐变色
- (void)drawLinearGradient:(CGRect)rect pointArray:(NSArray *)pointArray{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），设计给了两个颜色则这个数组有4*2个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[8] = {42.0/255.0,209.0/255.0,129.0/255.0,0.3,
                            255.0/255.0,255.0/255.0,255.0/255.0,1};
    CGFloat locations[2] = {0,1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations,2);
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient,CGPointMake(rect.size.width/2,0), CGPointMake(rect.size.width/2,self.height),kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
    
    
    
    CGPoint firstPoint = [pointArray.firstObject CGPointValue];
    CGPoint lastPoint = [pointArray.lastObject CGPointValue];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, firstPoint.x, firstPoint.y);
    
    for (int i = 1; i < pointArray.count; i ++) {
        CGPoint point = [pointArray[i] CGPointValue];
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    CGFloat padding = dot_2R / 2;
    CGPathAddLineToPoint(path, NULL, lastPoint.x + padding, lastPoint.y + padding);
    CGPathAddLineToPoint(path, NULL, lastPoint.x + padding, rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.size.width, 0);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, rect.size.height);
    CGPathAddLineToPoint(path, NULL, firstPoint.x, rect.size.height);
    CGPathAddLineToPoint(path, NULL, firstPoint.x,firstPoint.y);
    [UIColor.whiteColor set];
    CGContextSetLineWidth(context, 3);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
}

// 添加pointLabel的方法
- (void)addLabelWithTitle:(NSString *)title atLocation:(CGPoint)location andTag:(NSInteger)i {
    
    UIButton *button = [[UIButton alloc] init];
    
    
    if (self.isPercent) {
        [button setTitle:[NSString stringWithFormat:@"%@%%", title] forState:UIControlStateNormal];
    }else{
        [button setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
    }
    
    
    [button setTitleColor:self.pointTopLabelColor forState:UIControlStateNormal];
    button.titleLabel.font = self.textFont;
//    label.font = self.textFont;
    button.layer.backgroundColor = self.backColor.CGColor;
    button.tag = i;
    button.userInteractionEnabled = self.isPointUserInteractionEnabled;
    
    NSDictionary *attr = @{NSFontAttributeName : self.textFont};
    CGSize buttonSize = [button.currentTitle sizeWithAttributes:attr];
    
    button.width = buttonSize.width;
    button.height = buttonSize.height;
    button.x = location.x - button.width / 2;
    button.y = location.y - button.height - 3;
    [button addTarget:self action:@selector(pointDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (i == 0)
    {
        if (button.x < 0) {
            button.x = 0;
        }
        button.width = buttonSize.width  +10;
        button.height = buttonSize.height + 3;
//        button.layer.cornerRadius = 8;
//        button.backgroundColor = [UIColor colorWithRed:39/255.0 green:69/255.0 blue:93/255.0 alpha:1.0];
        button.y = location.y - button.height - 5;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    [self addSubview:button];
}

- (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

- (void)pointDidClicked:(UIButton *)button {
	
	self.selectedPoint.selected = NO;
    UIButton *pointButton = [self.pointButtonArray objectAtIndex:button.tag];
    pointButton.selected = YES;
    self.selectedPoint = pointButton;
	
	if ([self.delegate respondsToSelector:@selector(xAxisView:didClickButtonAtIndex:)]) {
		[self.delegate xAxisView:self didClickButtonAtIndex:button.tag];
	}
	
}

// 判断是小数还是整数
- (BOOL)isPureFloat:(NSString *)numStr
{
	//    NSScanner* scan = [NSScanner scannerWithString:string];
	//    float val;
	//    return [scan scanFloat:&val] && [scan isAtEnd];
	
	CGFloat num = [numStr floatValue];
	
	int i = num;
	
	CGFloat result = num - i;
	
	// 当不等于0时，是小数
	return result != 0;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//- (void)setFrame:(CGRect)frame{
//    [super setFrame:frame];
//
//    if (frame.size.width < UIScreen.mainScreen.bounds.size.width - 32*2) {
//        CGRect newFrame = frame;
//        newFrame.size.width = UIScreen.mainScreen.bounds.size.width - 32*2;
//        self.frame = newFrame;
//    }
//}

@end
