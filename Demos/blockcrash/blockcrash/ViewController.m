//
//  ViewController.m
//  blockcrash
//
//  Created by Joe.cheng on 2021/3/25.
//

#define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil

#import "ViewController.h"
#import <objc/runtime.h>


typedef ViewController *(^bgblock)(UIColor *color);
typedef BOOL (^end)();

@interface ViewController ()

- (instancetype)exist;

@property (nonatomic, copy, nonnull) bgblock bgcolor1;
@property (nonatomic, strong) end end;
@property (nonatomic, strong) ViewController *vc;



@end

@implementation ViewController

- (instancetype)exist{
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try {
        self.vc.bgcolor1(nil);
//            NSArray *arr = @[];
//            NSLog(@"%@",arr[10]);
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
//    self.vc = ViewController.new;
    self.vc.view.backgroundColor = UIColor.whiteColor;  // run fine
    self.vc.bgcolor1(nil);
    !self.vc ? : self.vc.bgcolor1(UIColor.whiteColor).end();
//    !self.?:self.vc.bgcolor1(UIColor.whiteColor);
//    self.vc.bgcolor1(UIColor.whiteColor); //crash Thread 1: EXC_BAD_ACCESS (code=1, address=0x10)
    NSLog(@"哈哈哈哈 xxxxxx");
    //    NSArray *arr = @[];
    //    NSLog(@"%@",arr[10]);
}

- (bgblock)bgcolor1{
    NSLog(@"bgblock getter");
    return ^(UIColor *color){
        NSLog(@"bgblock invoke");
        return self;
    };
    
}


@end


@implementation ViewController (hook)


bgblock globalBlock;

+(void)load{
//    Method oriMethod = class_getInstanceMethod([self class], @selector(dealloc));
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        if ([self isKindOfClass:ViewController.class]) {
            
            Method oriMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
            Method repMethod = class_getInstanceMethod([self class], @selector(replaceDelloc));
            method_exchangeImplementations(oriMethod, repMethod);
//        }
    });
    
    globalBlock = ^ViewController *(UIColor *color) {
            return nil;
        };

}
- (void)replaceDelloc{
    NSLog(@"delloc被替换了1111");
//    self.bgcolor1 = ^(UIColor *color){
//        //        self.view.backgroundColor = color;
//                return self;
//            };
    
//    self.bgcolor1 = ^ViewController *(UIColor *color) {
//        return nil;
//    };
    
//    dispatch_block_t blk = ^{
//
//    };
//    self.bgcolor1 = (bgblock){0x0};
//    self.bgcolor1 = globalBlock;
    
    NSLog(@"delloc被替换了2222");
}

@end
