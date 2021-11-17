//
//  THKShadowImageView.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/15.
//

#import "THKShadowImageView.h"

@interface THKShadowImageView ()

@property (nonatomic, strong, readwrite) UIImageView *contentImageView;


//@property (nonatomic, strong) UIColor *shadowColor;
//@property (nonatomic, assign) CGSize shadowOffset;
//@property (nonatomic, assign) CGFloat radius;
@end

@implementation THKShadowImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubviews];
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//
//    [self setLayerShadow:self.shadowColor offset:self.shadowOffset radius:self.radius];
//
//}

- (void)addSubviews{
    [self addSubview:self.contentImageView];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (void)setLayerShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius {
    [self setLayerShadow:color opacity:opacity offset:offset radius:radius spread:0];
}

- (void)setLayerShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius spread:(CGFloat)spread{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    if (spread == 0){
        self.layer.shadowPath = nil;
    } else {
        CGFloat dx = -spread;
        CGRect rect = CGRectInset(self.bounds, dx, dx);
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    }
}

- (void)setLayerCorner:(CGFloat)corner borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    self.contentImageView.layer.cornerRadius = corner;
    self.contentImageView.layer.borderColor = color.CGColor;
    self.contentImageView.layer.borderWidth = borderWidth;
}

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = UIImageView.new;
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _contentImageView;
}

@end
