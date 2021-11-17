//
//  ViewModel.m
//  HouseKeeper
//
//  Created by 熊熙 on 2020/8/31.
//  Copyright © 2020 binxun. All rights reserved.
//

#import "THKViewModel.h"
#import <objc/runtime.h>

NSString *const kModelIdKey = @"ModelIdKey";
NSString *const kModelDataKey = @"ModelDataKey";

@interface THKViewModel ()

@property (nonatomic, strong, readwrite) id model;

@end


@implementation THKViewModel

- (void)dealloc {
    NSLog(@"class=%@ dealloc",[self class]);
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    THKViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel
      rac_signalForSelector:@selector(initWithParams:)]
        subscribeNext:^(id x) {
            @strongify(viewModel)
            [viewModel initialize];
        }];
    [[viewModel
       rac_signalForSelector:@selector(initWithModel:)]
         subscribeNext:^(id x) {
             @strongify(viewModel)
             [viewModel initialize];
         }];
    return viewModel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)bindWithModel:(id)model {
    self.model = model;
}

- (instancetype)initWithParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        [params.allKeys enumerateObjectsUsingBlock:^(NSString   * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            const char * propertyName = [key UTF8String];
            objc_property_t property_t = class_getProperty([self class],propertyName);
            if (property_t != NULL) {
                //在类中没有定义的属性，父类不自动赋值，需要子类自行处理
                id value = [params valueForKey:key];
                [self setValue:value forKey:key];
            }
            else {
                NSString *param = [NSString stringWithFormat:@"属性名%@在%@不存在",key,[self class]];
                NSParameterAssert(param);
            }
        }];
    }
    return self;
}

/// sub class can override
- (void)initialize {}

@end
