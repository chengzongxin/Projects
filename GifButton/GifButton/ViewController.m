//
//  ViewController.m
//  GifButton
//
//  Created by Joe on 2019/8/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import "GifButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GifButton *thumupBtn;
@property (weak, nonatomic) IBOutlet GifButton *collectBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thumupBtn.text = @"100";
    self.collectBtn.text = @"300";
}

- (IBAction)clickButton:(GifButton *)sender {
    sender.selected = !sender.isSelected;
    int num = [sender.text intValue];
    if (sender.selected) {
        sender.text = [NSString stringWithFormat:@"%d",num + 1];
    }else{
        sender.text = [NSString stringWithFormat:@"%d",num - 1];
    }
    
}

@end
