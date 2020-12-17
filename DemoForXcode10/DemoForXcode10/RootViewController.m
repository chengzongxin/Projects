//
//  RootViewController.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/10.
//

#import "RootViewController.h"

@interface RootViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIEdgeInsets contentInset =  UIEdgeInsetsMake(1200, 0, 0, 0);
    scrollView.contentInset = contentInset;
    
    if (contentInset.top > self.view.bounds.size.height) {
        scrollView.contentOffset = CGPointMake(0, -contentInset.top);
    }
    
    scrollView.contentSize = CGSizeMake(0, 2000);
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    [redView addSubview:UISwitch.new];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.backgroundColor = UIColor.greenColor;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:redView];
    [scrollView addSubview:greenView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(self.view.bounds.size.width);
        make.top.mas_equalTo(-1200);
        make.height.mas_equalTo(1200);
    }];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(self.view.bounds.size.width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(800);
    }];
    
    _scrollView = scrollView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
