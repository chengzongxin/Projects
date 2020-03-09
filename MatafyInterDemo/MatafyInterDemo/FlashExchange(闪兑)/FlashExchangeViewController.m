//
//  FlashExchangeViewController.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "FlashExchangeViewController.h"
#import "ChooseSymbolView.h"
#import "ExchangePromptView.h"

@interface FlashExchangeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSymbolCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonReferenceCons;

@property (weak, nonatomic) IBOutlet UIImageView *symbolImageView;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *referenceImageView;
@property (weak, nonatomic) IBOutlet UILabel *referenceLabel;

@property (weak, nonatomic) IBOutlet UIButton *symbolChooseButton;
@property (weak, nonatomic) IBOutlet UIButton *referenceChooseButton;

@end

@implementation FlashExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Actions
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

- (IBAction)symbolChooseButtonClick:(id)sender {
    ChooseSymbolView *choose = ChooseSymbolView.new;
    [choose show];
}

- (IBAction)referenceChooseButtonClick:(id)sender {
    ChooseSymbolView *choose = ChooseSymbolView.new;
    [choose show];
}

- (IBAction)exchangeRateButtonClick:(id)sender {
    [ExchangePromptView show];
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
