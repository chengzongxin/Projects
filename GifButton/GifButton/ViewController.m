//
//  ViewController.m
//  GifButton
//
//  Created by Joe on 2019/8/23.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)clickButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

@end
