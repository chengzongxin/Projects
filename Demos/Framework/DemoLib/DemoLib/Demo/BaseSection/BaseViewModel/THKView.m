//
//  THKView.m
//  HouseKeeper
//
//  Created by 荀青锋 on 2019/5/6.
//  Copyright © 2019 binxun. All rights reserved.
//

#import "THKView.h"
#import "THKViewModel.h"
@interface THKView()

@property (nonatomic,strong) id model;

@property (nonatomic,strong) THKViewModel *viewModel;
@end

@implementation THKView

- (void)dealloc {
    NSLog(@"class=%@ dealloc",[self class]);
}

//普通代码初始化方法,若外部直接调用 alloc.init,也会走到此方法frame为{0,0,0,0}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self thk_setupViews];
    }
    return self;
}

// 初始化方法ViewModel
- (instancetype)initWithViewModel:(id)viewModel {
    self.viewModel = viewModel;
    self = [self init];
    if (self) {
        [self bindViewModel];
    }
    return self;
}

//xib初始化方法，此时子视图UI还未生成，只能作数据初始化相关的操作
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self thk_initViewModel:nil];
    }
    return self;
}

- (id)initWithModel:(id)model {
    //在view布局前赋值
    self.model = model;
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}

- (void)bindWithModel:(id)model {
    //更新model
    self.model = model;
}

- (void)bindViewModel:(id)viewModel {
    self.viewModel = viewModel;
    [self bindViewModel];
}

- (void)bindViewModel {
    
}

//xib初始化后子视图UI生成完成
- (void)awakeFromNib {
    [super awakeFromNib];
    [self thk_setupViews];
}

#pragma mark - THKViewProtocol

- (void)thk_initViewModel:(id)viewModel {}

- (void)thk_setupViews {}

@end
