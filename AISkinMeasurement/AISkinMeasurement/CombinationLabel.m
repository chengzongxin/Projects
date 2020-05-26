//
//  SkinLabel.m
//  AISkinMeasurement
//
//  Created by Joe on 2020/5/25.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "CombinationLabel.h"
#import "UIKitConvenient.h"

#define TheColor [UIColor colorWithRed:0/255.0 green:195/255.0 blue:206/255.0 alpha:1.0]

@interface CombinationLabel ()

@property (copy, nonatomic) NSString *leftText;
@property (copy, nonatomic) NSString *rightText;
@property (strong, nonatomic) NSDictionary<NSAttributedStringKey, id> *leftAttrs;
@property (strong, nonatomic) NSDictionary<NSAttributedStringKey, id> *rightAttrs;

@property (assign, nonatomic) CGFloat drawY;
@property (assign, nonatomic) CGFloat drawLeftWidth;
@property (assign, nonatomic) CGFloat drawRightWidth;
@property (assign, nonatomic) CGFloat margin;


@end

@implementation CombinationLabel

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self inital];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self inital];
    }
    return self;
}

- (void)inital{
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 4;
    self.layer.borderColor = TheColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    self.leftAttrs = @{NSForegroundColorAttributeName:TheColor,NSFontAttributeName:[UIFont systemFontOfSize:10]};
    self.rightAttrs = @{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:10]};
    self.margin = 3;
}

- (void)setLeftText:(NSString *)leftText rightText:(NSString *)rightText{
    _leftText = leftText;
    _rightText = rightText;
    
    CGSize leftSize = [leftText sizeWithAttributes:self.leftAttrs];
    CGSize rightSize = [rightText sizeWithAttributes:self.rightAttrs];
    
    self.drawY = (self.height - leftSize.height)/2;
    self.drawLeftWidth = leftSize.width + _margin * 2;
    self.drawRightWidth = rightSize.width + _margin * 2;
    
    // 使用frame布局
    self.width = leftSize.width + rightSize.width + _margin * 4;
/*
    firstItem
    <CombinationLabel: 0x101d0bf40; frame = (86 674; 83.54 34); clipsToBounds = YES; autoresize = RM+BM; layer = <CALayer: 0x2826d8ae0>>

    firstAttribute
    NSLayoutAttributeWidth

    relation
    NSLayoutRelationEqual

    secondItem
    nil
 
    secondAttribute
    NSLayoutAttributeNotAnAttribute
 
    multiplier
    1
 
    constant
    240
 */
    // 使用约束布局
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == NSLayoutAttributeWidth) {
            obj.constant = self.width;
        }
    }];
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置画笔属性
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetFillColorWithColor(ctx, TheColor.CGColor);
    
    CGContextMoveToPoint(ctx, self.drawLeftWidth, 0);
    CGContextAddLineToPoint(ctx, self.drawLeftWidth, self.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    [_leftText drawAtPoint:CGPointMake(self.margin, self.drawY) withAttributes:self.leftAttrs];
    [_rightText drawAtPoint:CGPointMake(self.margin + self.drawLeftWidth, self.drawY) withAttributes:self.rightAttrs];
}

@end
