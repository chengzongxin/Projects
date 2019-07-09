//
//  DrawView.m
//  画板
//
//  Created by Joe on 2019/7/8.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import "DrawView.h"
#import "UIBezierPath+Extension.h"

@interface DrawView ()

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) NSMutableArray *paths;

@property (assign, nonatomic) CGFloat width;

@property (strong, nonatomic) UIColor *color;

@end

@implementation DrawView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    _paths = [NSMutableArray array];
    _width = 3;
    _color = UIColor.blackColor;
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint curP = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.path = [UIBezierPath bezierPath];
        [self.path moveToPoint:curP];
        [self.path setLineWidth:self.width];
        self.path.color = self.color;
        [self.paths addObject:self.path];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:curP];
        
        [self setNeedsDisplay];
    }
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIBezierPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *img = (UIImage *)path;
            [img drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
    }
}

- (void)setLineWidth:(CGFloat)lineWidth{
    self.width = lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor{
    self.color = lineColor;
}

- (void)clear{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)undo{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

- (void)erase{
    self.color = UIColor.whiteColor;
}

- (void)setImage:(UIImage *)image {
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

@end
