//
//  ViewController.m
//  RACDemo
//
//  Created by Joe.cheng on 2021/4/19.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, strong) RACSignal *signalA;
@property (nonatomic, strong) RACSignal *signalB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [subscriber sendNext:@[@22]];
//            [subscriber sendCompleted];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@[@33]];
                [subscriber sendCompleted];
            });
        });
        return nil;
    }];
    
    _signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [subscriber sendNext:@[@11]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    
    [[RACSignal combineLatest:@[_signalA,_signalB] reduce:^id (id a, id b) {
        return @[a,b];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"subscribeNext = %@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"error = %@",error);
    } completed:^{
        NSLog(@"completed");
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.signalA
}


@end
