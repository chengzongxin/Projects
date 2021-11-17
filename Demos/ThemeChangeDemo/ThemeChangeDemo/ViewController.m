//
//  ViewController.m
//  Test
//
//  Created by Joe.cheng on 2021/4/7.
//

#import "ViewController.h"
#import "CustomColor.h"
#import "UIView+ThemeChange.h"

@interface ViewController ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    _label.text = @"ceshi  color dynamic";
    [self.view addSubview:_label];


    self.view.backgroundColor = [CustomColor dynamicColor:_count blk:^UIColor * _Nonnull(int count) {
        if (_count %2) {
            return UIColor.orangeColor;
        }else{
            return UIColor.yellowColor;
        }
    }];

    _label.textColor = [CustomColor dynamicColor:_count blk:^UIColor * _Nonnull(int count) {
        if (_count %2) {
            return UIColor.greenColor;
        }else{
            return UIColor.blueColor;
        }
    }];

    self.view.tag = 999;
    self.label.tag = 999;

    UIColor *bgColor = self.view.backgroundColor;
    NSLog(@"%@",bgColor);

    NSLog(@"dddddd");
    
    
//    self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//        if (traitCollection.userInterfaceStyle ==  UIUserInterfaceStyleDark) {
//            return UIColor.orangeColor;
//        }else{
//            return UIColor.yellowColor;
//        }
//    }];
    
}

int _count = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.view.backgroundColor = [CustomColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//        return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ? UIColor.grayColor : UIColor.orangeColor;
//    }];
    _count++;
    [self changeTheme];
    NSLog(@"TOUCH BEGIN");
}


- (void)changeTheme{
    [UIApplication.sharedApplication.windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull window, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!window.hidden && window.alpha > 0.01 && window.rootViewController) {
//            [window.rootViewController qmui_themeDidChangeByManager:self identifier:self.currentThemeIdentifier theme:self.currentTheme];
//
//            // 某些 present style 情况下，window 上可能存在多个 viewController.view，因此需要遍历所有的 subviews，而不只是 window.rootViewController.view
//            [window _qmui_themeDidChangeByManager:self identifier:self.currentThemeIdentifier theme:self.currentTheme shouldEnumeratorSubviews:YES];
//            [window _qmui_themeDidChangeByManager];
            [window _qmui_themeDidChangeByManager:YES];
        }
    }];
}

@end
