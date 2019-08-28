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
@property (strong, nonatomic) GifButton *commentBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.thumupBtn.text = @"1000000";
    self.collectBtn.text = @"30000";
    
    _commentBtn = [GifButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.gifName = @"点赞";
    _commentBtn.normalImage = [UIImage imageNamed:@"点赞"];
    _commentBtn.frame = CGRectMake(100, 200, 29, 29);
    _commentBtn.text = @"333333";
    [self.view addSubview:_commentBtn];
    
    [_commentBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
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
