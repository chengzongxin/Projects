//
//  ViewController.m
//  MacAppDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet NSTextField *inputTextField;

@property (weak) IBOutlet NSTextField *outputTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)buttonClick:(id)sender {
    NSString *rawStr =  self.inputTextField.stringValue?:@"";
    NSString *temptext = [rawStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 去除2端的空格
    NSString *text = [temptext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // 去除回车
    NSURL *url = [NSURL URLWithString:text];
    NSString *queryStr = url.lastPathComponent;
//    NSArray *arr = [self calculateSubStringCount:queryStr str:@"_"];
    
//    NSLog(@"%@",arr);
    [self transString:queryStr];
    
    
    self.outputTextField.stringValue = [self transString:queryStr];
}


- (NSString *)transString:(NSString *)str{
    
    NSMutableArray *indexs = [NSMutableArray array];
    for (int i = 0; i<str.length; i++) {
        char commitChar = [str characterAtIndex:i];
        NSString *temp = [str substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            
            NSLog(@"字符串中含有中文");
        }else if((commitChar>64)&&(commitChar<91)){
            
            NSLog(@"字符串中含有大写英文字母");
            [indexs addObject:@(i)];
        }else if((commitChar>96)&&(commitChar<123)){
            
            NSLog(@"字符串中含有小写英文字母");
        }else if((commitChar>47)&&(commitChar<58)){
            
            NSLog(@"字符串中含有数字");
        }else{
            
            NSLog(@"字符串中含有非法字符");
        }
    }
    
    NSMutableString *string = [NSMutableString stringWithString:str];
    for (NSInteger i = indexs.count - 1; i >=0; i --) {
        NSInteger index = [indexs[i] integerValue];
        [string insertString:@"_" atIndex:index];
    }
    
    [string insertString:@"URL_" atIndex:0];
    
    return [string uppercaseString];
}
@end
