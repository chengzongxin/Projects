//
//  GifButton.m
//  GifButton
//
//  Created by Joe on 2019/8/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "GifButton.h"

@interface GifButton ()

@property (strong, nonatomic) UIImageView *animateImageView;

@end

@implementation GifButton

//- (void)dealloc{
//    NSLog(@"%s",__FUNCTION__);
//    [self.animateImageView removeObserver:self forKeyPath:@"isAnimating"];
//    [self.animateImageView removeObserver:self forKeyPath:@"animating"];
//}
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    [self addSubview:self.animateImageView];
    _normalImage = self.currentImage;
    
    [self addSubview:self.textLabel];
    
//    [self.animateImageView addObserver:self forKeyPath:@"isAnimating" options:NSKeyValueObservingOptionNew context:nil];
//    [self.animateImageView addObserver:self forKeyPath:@"animating" options:NSKeyValueObservingOptionNew context:nil];
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@",change);
//}

#pragma mark - Event response
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        UIImage *normalImage = self.currentImage;
        [self setImage:[UIImage new] forState:UIControlStateNormal];
        [self.animateImageView startAnimating];
        self.enabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setImage:normalImage forState:UIControlStateNormal];
            self.enabled = YES;
        });
    }
}

#pragma mark - Private Method
#pragma mark 根据gif返回一组frame图片
- (NSArray *)imagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frames addObject:image];
        CGImageRelease(imageRef);
    }
    return frames;
}


#pragma mark - Setter & Gettser

- (void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    [self setImage:normalImage forState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (void)setGifName:(NSString *)gifName{
    _gifName = gifName;
    
    self.animateImageView.animationImages = [self imagesWithGif:gifName];
    NSAssert(self.animateImageView.animationImages.count, @"没有图片");
    [self setImage:self.animateImageView.animationImages.lastObject forState:UIControlStateSelected];
}

- (void)setAnimateImages:(NSArray<UIImage *> *)animateImages{
    _animateImages = animateImages;
    NSAssert(animateImages.count, @"没有图片");
    self.animateImageView.animationImages = animateImages;
    [self setImage:animateImages.lastObject forState:UIControlStateSelected];
}

- (void)setAnimateDuration:(int)animateDuration{
    self.animateImageView.animationDuration = animateDuration;
}

- (void)setAnimateRepeatCount:(int)animateRepeatCount{
    self.animateImageView.animationRepeatCount = animateRepeatCount;
}

- (void)setText:(NSString *)text{
    self.textLabel.text = text;
}

- (NSString *)text{
    return self.textLabel.text;
}

- (UIImageView *)animateImageView{
    if (!_animateImageView) {
        _animateImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _animateImageView.animationImages = @[];
        _animateImageView.animationDuration = 1;
        _animateImageView.animationRepeatCount = 1;
    }
    return _animateImageView;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.frame = CGRectMake(self.bounds.size.width, -10, 40, 20);
        _textLabel.textColor = [UIColor colorWithRed:130/255.0 green:128/255.0 blue:128/255.0 alpha:1.0];
        _textLabel.font = [UIFont systemFontOfSize:10];
        _textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _textLabel;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.animateImageView.frame = self.bounds;
    self.textLabel.frame = CGRectMake(self.bounds.size.width, -10, 40, 20);
}


//- (CGSize)singleLineSizeWithLabel:(UILabel *)label Text:(UIFont *)font{
//    return [label sizeWithAttributes:@{NSFontAttributeName:label.font}];
//}

@end
