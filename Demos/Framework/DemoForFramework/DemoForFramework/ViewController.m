//
//  ViewController.m
//  DemoForFramework
//
//  Created by Joe.cheng on 2021/1/7.
//

#import "ViewController.h"
//#import <LibA/Person.h>
//#import <LibA/LibA.h>
//#import <LibA/LibA.h>
#import <LibA/LibA.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewdidlaod");
//    [Person.new print];
    
    [Person print];
}


@end
