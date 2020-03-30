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

- (NSString *)noEnterString:(NSString *)rawString{
    //去掉字符串中的空格和回车,改为空格
    NSMutableString *noEnterStr = [NSMutableString stringWithString:rawString];
    
//    NSRange range = {0,rawStr.length};
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,rawString.length};
    
    [noEnterStr replaceOccurrencesOfString:@"\n" withString:@" " options:NSLiteralSearch range:range2];
    NSLog(@"去掉字符串中的空格和回车%@",noEnterStr);
    
    
    NSString *temptext = [noEnterStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 去除2端的空格
    NSString *text = [temptext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // 去除回车
    
    return text;
}

- (NSString *)machUrl:(NSString *)rawStr{
    NSError *error;
    // 匹配所有网址
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:rawStr options:0 range:NSMakeRange(0, [rawStr length])];
    NSMutableString *urlString = [NSMutableString string];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [rawStr substringWithRange:match.range];
        [urlString appendString:substringForMatch];
        NSLog(@"substringForMatch %@",substringForMatch);
    }
    return urlString;
}


- (IBAction)buttonClick:(id)sender {
    NSString *rawStr = [self noEnterString:self.inputTextField.stringValue?:@""];
    
    NSString *urlString = [self machUrl:rawStr];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *queryStr = url.lastPathComponent;
    
    NSString *comment = [rawStr substringToIndex:[rawStr rangeOfString:urlString].location];
    NSString *macro = [self transString:queryStr];
    NSString *macroDefine = [NSString stringWithFormat:@"HOST(@\"%@\")",url.path];
    NSMutableString *content = [NSMutableString string];
    
    [content appendFormat:@"/* %@ */\n",comment];
    [content appendFormat:@"#define %@",macro];
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
