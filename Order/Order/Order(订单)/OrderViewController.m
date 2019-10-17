//
//  ViewController.m
//  Order
//
//  Created by Joe on 2019/10/16.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "OrderViewController.h"
#import <SPPageMenu.h>
#import "OrderCategoryView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NAVBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height + 44
#define pageMenuH 44
#define scrollViewHeight (SCREEN_HEIGHT-NAVBAR_HEIGHT-pageMenuH)


@interface OrderViewController ()<SPPageMenuDelegate,UIScrollViewDelegate>


@property (strong, nonatomic) UIView *menuBgView;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;

@property (strong, nonatomic) OrderCategoryView *orderCategoryView;


@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSelf];
    
    [self setupMenu];
    
    [self addChildVC];
    
    [self.orderCategoryView loadDatas];
}

- (void)initSelf{
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    [titleButton setTitle:@"全部分类" forState:UIControlStateNormal];
    [titleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"order_title_icon"] forState:UIControlStateNormal];
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    titleButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

//MARK: 初始化subviews
- (void)setupMenu{
    self.dataArr = @[@"全部",@"待支付",@"处理中/完成",@"待出行",@"退款/售后"];
    
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.trackerWidth = 36;
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    pageMenu.selectedItemTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    pageMenu.unSelectedItemTitleFont = [UIFont systemFontOfSize:13];
    pageMenu.selectedItemTitleColor = [UIColor colorWithRed:42/255.0 green:50/255.0 blue:63/255.0 alpha:1.0];
    pageMenu.unSelectedItemTitleColor = [UIColor colorWithRed:87/255.0 green:102/255.0 blue:122/255.0 alpha:1.0];
    pageMenu.tracker.backgroundColor = [UIColor colorWithRed:0/255.0 green:227/255.0 blue:233/255.0 alpha:1.0];
    pageMenu.dividingLine.hidden = YES;
    
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    // add Views
    [self.view addSubview:pageMenu];
    
    _pageMenu = pageMenu;
    
}

- (void)addChildVC{
    NSArray *controllerClassNames = @[@"OrderAllViewController",@"OrderWaitPayViewController",@"OrderProcessingViewController",@"OrderWaitUseViewController",@"OrderServiceViewController"];
    for (int i = 0; i < self.dataArr.count; i++) {
        if (controllerClassNames.count > i) {
            UIViewController *baseVc = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            [self addChildViewController:baseVc];
            // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
            [self.myChildViewControllers addObject:baseVc];
        }
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+pageMenuH, SCREEN_WIDTH, scrollViewHeight)];
//    scrollView.backgroundColor = ColorHex(0xF7F7FB);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        UIViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0, SCREEN_WIDTH, scrollViewHeight);
        scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*self.pageMenu.selectedItemIndex, 0);
        scrollView.contentSize = CGSizeMake(self.dataArr.count*SCREEN_WIDTH, 0);
    }
}


#pragma mark - SPPageMenu的代理方法

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    //    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    
    
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    /// 比码页隐藏搜索框
    if (toIndex == 1) {
        
    }
    
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded])
    {
        // call viewwillappear
        [targetViewController viewWillAppear:YES];
        
        return;
    }
    
    targetViewController.view.frame = CGRectMake(SCREEN_WIDTH * toIndex, 0, SCREEN_WIDTH, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
    
}


#pragma mark - Event

- (void)titleButtonClick:(UIButton *)button{
    button.selected = !button.isSelected;
    NSLog(@"%s",__FUNCTION__);
    // 动画
    [UIView animateWithDuration:0.2 animations:^{
        if (button.selected) {
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            button.imageView.transform = CGAffineTransformIdentity;
        }
    }];
    
    // 弹出菜单
    if (button.selected) {
        [self.orderCategoryView show];
    }else{
        [self.orderCategoryView dismiss];
    }
}

- (void)didTapItem{
    
}


#pragma mark - getter

- (NSMutableArray *)myChildViewControllers {
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}

- (OrderCategoryView *)orderCategoryView{
    if (!_orderCategoryView) {
        _orderCategoryView = [[OrderCategoryView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
        __weak typeof(self) weakSelf = self;
        _orderCategoryView.tapItem = ^(NSIndexPath * _Nonnull indexPath) {
            NSLog(@"%@",indexPath);
            [weakSelf didTapItem];
        };
        [self.view addSubview:_orderCategoryView];
    }
    return _orderCategoryView;
}


#pragma mark - NSObject

- (void)loadDatas{
    for (UIViewController *vc in self.childViewControllers) {
        if (vc && [vc respondsToSelector:@selector(loadDatas)]) {
            [vc performSelector:@selector(loadDatas)];
        }
        return;
    }
}

@end
