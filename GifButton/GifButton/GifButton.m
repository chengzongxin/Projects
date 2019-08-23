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
    
//    [self.animateImageView addObserver:self forKeyPath:@"isAnimating" options:NSKeyValueObservingOptionNew context:nil];
//    [self.animateImageView addObserver:self forKeyPath:@"animating" options:NSKeyValueObservingOptionNew context:nil];
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@",change);
//}


- (void)setSelected:(BOOL)selected {
    if (selected) {
        UIImage *normalImage = self.currentImage;
        [self setImage:[UIImage new] forState:UIControlStateNormal];
        [self.animateImageView startAnimating];
        self.enabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setImage:normalImage forState:UIControlStateNormal];
            [super setSelected:selected];
            self.enabled = YES;
        });
    }else{
        [super setSelected:selected];
    }
}

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
    [self setImage:self.animateImageView.animationImages.lastObject forState:UIControlStateSelected];
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

- (void)setAnimateDuration:(int)animateDuration{
    self.animateImageView.animationDuration = animateDuration;
}

- (void)setAnimateRepeatCount:(int)animateRepeatCount{
    self.animateImageView.animationRepeatCount = animateRepeatCount;
}

@end
