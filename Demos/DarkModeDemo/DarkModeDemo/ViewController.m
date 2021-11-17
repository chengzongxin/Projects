//
//  ViewController.m
//  DarkModeDemo
//
//  Created by Joe.cheng on 2021/4/14.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *normalTitleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 300, 50)];
    [self.view addSubview:_bgView];
    _bgView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        return traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight? UIColor.orangeColor:UIColor.greenColor;
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    _titleLabel.text = @"titleLabel";
    [self.view addSubview:self.titleLabel];
    [self.titleLabel setTextColor:[UIColor labelColor]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    
    self.normalTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 100, 50)];
    self.normalTitleLabel.text = @"normalTitleLabel";
    [self.view addSubview:self.normalTitleLabel];
    [self.normalTitleLabel setTextColor:[UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        return traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight? UIColor.redColor:UIColor.yellowColor;
    }]];

    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    self.detailLabel.text = @"detailLabel";
    [self.view addSubview:self.detailLabel];
    [self.detailLabel setTextColor:[UIColor placeholderTextColor]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 300, 200)];
    [self.view addSubview:_imageView];
    self.imageView.image = [UIImage imageNamed:@"Image"];

    
    NSLog(@"%@,%@,%@",self.titleLabel.textColor,self.normalTitleLabel.textColor,self.detailLabel.textColor);
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(100, 500, 100, 40);
    [self.view addSubview:_button];
    [_button setTitle:@"button click" forState:UIControlStateNormal];
    _button.backgroundColor = UIColor.grayColor;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 300, 44)];
//    _textField.placeholder = @"input";
    _textField.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:_textField];
    
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    // trait发生了改变
    if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
        NSLog(@"trait发生了改变");
        NSLog(@"previousTraitCollection = %@",previousTraitCollection);
        NSLog(@"traitCollection = %@",self.traitCollection);
        // 执行操作
    }
    
}



@end
