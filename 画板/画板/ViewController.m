//
//  ViewController.m
//  画板
//
//  Created by Joe on 2019/7/8.
//  Copyright © 2019年 Joe. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}
- (IBAction)setLineColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)photo:(id)sender {
}
- (IBAction)save:(id)sender {
}



@end
