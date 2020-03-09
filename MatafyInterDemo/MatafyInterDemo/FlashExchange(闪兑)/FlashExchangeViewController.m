//
//  FlashExchangeViewController.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "FlashExchangeViewController.h"

@interface FlashExchangeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSymbolCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonReferenceCons;

@property (weak, nonatomic) IBOutlet UIImageView *symbolImageView;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *referenceImageView;
@property (weak, nonatomic) IBOutlet UILabel *referenceLabel;

@end

@implementation FlashExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)exchangeParityButtonClick:(UIButton *)sender {
    NSLog(@"%s",__func__);
    sender.selected = !sender.selected;
    
    [self replace:self.symbolImageView topCons:(sender.selected ? 126 : 20)];
    [self replace:self.referenceImageView topCons:(sender.selected ? 20 : 126)];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


// 替换约束
- (void)replace:(UIView *)view topCons:(CGFloat)topConstant{
    for (NSLayoutConstraint *cons in view.superview.constraints) {
        if (cons.firstItem == view && cons.firstAttribute == NSLayoutAttributeTop) {
            cons.constant = topConstant;
            break;
        }
    }
}

@end
