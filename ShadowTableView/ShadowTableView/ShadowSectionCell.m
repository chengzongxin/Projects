//
//  ShadowSectionCell.m
//  ShadowTableView
//
//  Created by Joe on 2020/3/5.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ShadowSectionCell.h"

static CGFloat const inset = 5;

@implementation ShadowSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSelf];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initSelf];
}

- (void)initSelf{
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = NO;
    
    ShadowCellShadowView *bgView = [[ShadowCellShadowView alloc] init];
    
    [self insertSubview:bgView atIndex:0];
    
    self.bgView= bgView;
    
    CAShapeLayer *shadow = [CAShapeLayer layer];
    
    shadow.shadowColor = [UIColor blackColor].CGColor;
    
    shadow.shadowOffset=CGSizeMake(0,0);
    
    shadow.shadowOpacity=0.10;
    
    [bgView.layer addSublayer:shadow];
    
    bgView.shadowLayer= shadow;
    
    
    CALayer*line = [CALayer layer];
    
    line.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    [bgView.layer addSublayer:line];
    
    bgView.separatorLine= line;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    UIBezierPath*bgBezierPath =nil;
    
    CGFloat cornerRaduis =10.0;//觉得阴影大的可以把半径调小,半径大的话阴影面积会变大
    
    
    
    if([self getNumberOfRowInCurrentCell] == 1) {//单组单行
        
        self.bgView.clipsToBounds=NO;
        
        self.bgView.frame=self.bounds;
        
        CGRect rect = UIEdgeInsetsInsetRect(self.bgView.bounds, UIEdgeInsetsMake(0, inset, 0, inset));
        
        bgBezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRaduis, cornerRaduis)];
        
        
        
    }else if(self.indexPath.row == 0) {// 第一行
        
        self.bgView.clipsToBounds=YES;
        
        self.bgView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(-5, 0, 0, 0));
        
        CGRect rect = UIEdgeInsetsInsetRect(self.bgView.bounds, UIEdgeInsetsMake(5, inset, 0, inset));
        
        bgBezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRaduis, cornerRaduis)];
        
        
        
    }else if(self.indexPath.row == [self getNumberOfRowInCurrentCell]-1) {// 最后一行
        
        self.bgView.clipsToBounds=YES;
        
        self.bgView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 0, -5, 0));
        
        CGRect rect = UIEdgeInsetsInsetRect(self.bgView.bounds, UIEdgeInsetsMake(0, inset, 5, inset));
        
        bgBezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)  cornerRadii:CGSizeMake(cornerRaduis, cornerRaduis)];
        
        
        
    }else{// 中间行
        
        self.bgView.clipsToBounds=YES;
        
        self.bgView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 0, 0, 0));
        
        CGRect rect = UIEdgeInsetsInsetRect(self.bgView.bounds, UIEdgeInsetsMake(0, inset, 0, inset));
        
        bgBezierPath = [UIBezierPath bezierPathWithRect:rect];
        
        
        
    }
    
    
    
    self.bgView.shadowLayer.path= bgBezierPath.CGPath;
    
    self.bgView.shadowLayer.shadowPath= bgBezierPath.CGPath;
    
    self.bgView.shadowLayer.fillColor = [UIColor whiteColor].CGColor;
    
    
    
    
    
    //分割线 非单组单行 非最后一行
    
    if(!(self.indexPath.row==0&&self.indexPath.section==1) && !(self.indexPath.row==self.indexPath.section-1)) {
        
        self.bgView.separatorLine.frame = CGRectMake(self.bgView.frame.origin.x+30, self.bgView.frame.size.height-1, self.bgView.frame.size.width-30*2, 1.0);
        
    }
    
}


- (UITableView *)getTableView{
    UIView *view = [self superview];
    
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    
    UITableView *tableView = (UITableView *)view;
    return tableView;
}

- (NSInteger)getNumberOfRowInCurrentCell{
    return [[self getTableView] numberOfRowsInSection:self.indexPath.section];
}

@end



@implementation ShadowCellShadowView

@end

 
