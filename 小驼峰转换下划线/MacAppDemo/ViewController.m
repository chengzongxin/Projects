//
//  ViewController.m
//  MacAppDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSTextFieldDelegate>
@property (weak) IBOutlet NSTextField *inputTextField;

@property (weak) IBOutlet NSTextField *outputTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
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
//    [self transString:queryStr];

    //    http://112.90.89.15:18807/token-wallet-app/withdraw/query/withdrawOrderPageQuery
        // HOST -- eg: HOST(@"/token-wallet-app/recharge/query/rechargeOrderDetailQuery")
        // /token-wallet-app/withdraw/query/withdrawOrderPageQuery
    
    NSString *macro = [self transString:queryStr];
    NSString *macroDefine = [NSString stringWithFormat:@"HOST(@\"%@\")",url.path];
    NSMutableString *content = [NSMutableString string];
    [content appendString:macro];
    [content appendString:@"    "];
    [content appendString:macroDefine];
    
    self.outputTextField.stringValue = content;
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

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    NSLog(@"Selector method is (%@)", NSStringFromSelector( commandSelector ) );
    if (commandSelector == @selector(insertNewline:)) {
            //Do something against ENTER key
        [self buttonClick:nil];
    } else if (commandSelector == @selector(deleteForward:)) {
            //Do something against DELETE key
    } else if (commandSelector == @selector(deleteBackward:)) {
            //Do something against BACKSPACE key
    } else if (commandSelector == @selector(insertTab:)) {
            //Do something against TAB key
    }
    // return YES if the action was handled; otherwise NO
    return NO;
}


@end
