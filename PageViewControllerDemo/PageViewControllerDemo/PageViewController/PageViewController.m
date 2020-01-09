//
//  PageViewController.m
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "PageViewController.h"
#import "PageScrollView.h"
#import "UIView+Frame.h"
// 下划线额外宽度
CGFloat const underLineAdditionW = 6;

@interface PageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, strong) UIScrollView *contentScrollView;


@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) PageScrollView *bgScrollView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation PageViewController

- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"网易新闻";
    self.containerView = self.view;
    
    self.header = [self setupHeaderView];
    
    [self setupAllChildViewController];
    
    // 1.添加标题滚动视图
    [self setupTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setupContentScrollView];
    
    
    [self setupAllTitle];
    
    
    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 5.处理标题点击
    
    // 6.处理内容滚动视图滚动
    
    // 7.选中标题居中 => 选中标题
    
}

#pragma mark - Public 交给子类实现
- (void)setupAllChildViewController{
    NSAssert(0, [NSString stringWithFormat:@"必须实现setupAllChildViewController方法"]);
}


- (UIView *)setupHeaderView{
    return nil;
}


#pragma mark - UIScrollViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        // 获取当前角标
        NSInteger i = scrollView.contentOffset.x / ScreenW;
        
        // 获取标题按钮
        UIButton *titleButton = self.titleButtons[i];
        
        // 1.选中标题
        [self selButton:titleButton];
        
        // 2.把对应子控制器的view添加上去
        [self setupOneViewController:i];
    }
}

// 只要一滚动就需要字体渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.bgScrollView) {
//        NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
        CGFloat top = self.header.height - scrollView.contentInset.top;
        // 如果offset 滑动大于top ,或者 tag = 0 ,bgScroll头部固定不动
        // 如果子视图tableview滑动到顶部时(即tableview.offset <= 0),tag = 1, 头部允许往下滑动
        if (scrollView.contentOffset.y >= top || scrollView.tag == 0) {
            scrollView.contentOffset = CGPointMake(0, top);
        }
        // tag == 1
        
    }else if (scrollView == self.contentScrollView) {
        
        // 字体缩放 1.缩放比例 2.缩放哪两个按钮
        NSInteger leftI = scrollView.contentOffset.x / ScreenW;
        NSInteger rightI = leftI + 1;
        
        // 获取左边的按钮
        UIButton *leftBtn = self.titleButtons[leftI];
        NSInteger count = self.titleButtons.count;
        
        // 获取右边的按钮
        UIButton *rightBtn;
        if (rightI < count) {
            rightBtn = self.titleButtons[rightI];
        }
        
        // 0 ~ 1 =>  1 ~ 1.3
        // 计算缩放比例
        CGFloat scaleR = scrollView.contentOffset.x / ScreenW;
        
        scaleR -= leftI;
        
        // 左边缩放比例
        CGFloat scaleL = 1 - scaleR;
        
        // 缩放按钮
        leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
        rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
        
        // 颜色渐变
        UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
        UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
        [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
        [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
        
        CGFloat xDistance = rightBtn.center.x - leftBtn.center.x;
        
        // 普通样式滑动下划线
        //    CGFloat offset = xDistance * scaleR;
        //    _underLine.center = CGPointMake(leftBtn.center.x + offset, _underLine.center.y);
        
        // 依恋样式
        // 这种样式的计算比较复杂,有个很关键的技巧，就是参考progress分别为0、0.5、1时的临界值
        // 原先的x值
        CGRect newFrame = _underLine.frame;
        // 原先的宽度
        CGFloat originW = leftBtn.titleLabel.frame.size.width / 2 + underLineAdditionW;
        CGFloat originX = leftBtn.center.x - originW / 2;
        if (scaleR < 0.5) {
            newFrame.origin.x = originX; // x值保持不变
            newFrame.size.width = originW + xDistance * scaleR * 2;
        } else {
            newFrame.origin.x = originX + xDistance * (scaleR-0.5) * 2;
            newFrame.size.width = originW + xDistance - xDistance * (scaleR-0.5) * 2;
        }
        _underLine.frame = newFrame;
    }
    
}

/*
 颜色:3种颜色通道组成 R:红 G:绿 B:蓝
 
 白色: 1 1 1
 黑色: 0 0 0
 红色: 1 0 0
 */

#pragma mark - 选中标题
- (void)selButton:(UIButton *)button
{
    _selectButton.transform = CGAffineTransformIdentity;
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // 标题居中
    [self setupTitleCenter:button];
    
    // 字体缩放:形变
    button.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    _selectButton = button;
    
    // 改变下划线位置
    [button.titleLabel sizeToFit];
    CGRect frame = _underLine.frame;
    frame.size.width = button.titleLabel.frame.size.width + underLineAdditionW;
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.frame = frame;
        self.underLine.center = CGPointMake(button.center.x, self.underLine.center.y);
    }];
    
}

#pragma mark - 标题居中
- (void)setupTitleCenter:(UIButton *)button
{
    // 本质:修改titleScrollView偏移量
    CGFloat offsetX = button.center.x - ScreenW * 0.5;
    // 处理最小偏移量
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ScreenW;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset: CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - 添加一个子控制器的View
- (void)setupOneViewController:(NSInteger)i
{
    
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) {
        return;
    }
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    vc.view.frame = CGRectMake(x, 0, ScreenW  , self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark - 处理标题点击
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    // 1.标题颜色 变成 红色
    [self selButton:button];
    
    // 2.把对应子控制器的view添加上去
    [self setupOneViewController:i];
    
    // 3.内容滚动视图滚动到对应的位置
    CGFloat x = i * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}

#pragma mark - 设置所有标题
- (void)setupAllTitle
{
    // 已经把内容展示上去 -> 展示的效果是否是我们想要的(调整细节)
    // 1.标题颜色 为黑色
    // 2.需要让titleScrollView可以滚动
    
    // 添加所有标题按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    CGFloat btnX = 0;
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        titleButton.frame = CGRectMake(btnX, 0, btnW, btnH);
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 监听按钮点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 把标题按钮保存到对应的数组
        [self.titleButtons addObject:titleButton];
        
        [self.titleScrollView addSubview:titleButton];
        
//        if (i == 0) {
//            [self titleClick:titleButton];
//        }
    }
    
    
    // 设置标题的滚动范围
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);
    
    [self titleClick:self.titleButtons.firstObject];
    
    // bug:代码跟我的一模一样,但是标题就是显示不出来
    // 内容往下移动,莫名其妙
}


#pragma mark - 添加标题滚动视图
- (void)setupTitleScrollView
{
    // 创建titleScrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    CGFloat stautsH = UIApplication.sharedApplication.statusBarFrame.size.height;
    CGFloat navH = (self.navigationController.navigationBar && !self.navigationController.navigationBarHidden)? 44 : 0;
    CGFloat headerH = self.header.frame.size.height;
    CGFloat y = headerH ?:(stautsH + navH);
    titleScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, 44);
    [self.containerView addSubview:titleScrollView];
    _titleScrollView = titleScrollView;
    
    // 设置下划线
    [self setupTitleUnderline];
}
// 设置下划线
- (void)setupTitleUnderline{
    UIView *underLine = [[UIView alloc] init];
    underLine.frame = CGRectMake(0, _titleScrollView.frame.size.height - 3, 0, 3);
    underLine.backgroundColor = UIColor.redColor;
    [_titleScrollView addSubview:underLine];
    _underLine = underLine;
}

#pragma mark - 添加内容滚动视图
- (void)setupContentScrollView
{
    // 创建contentScrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat height = self.view.bounds.size.height - y;
    if (self.header) {
        height = ScreenH - (kStatusH + kNavbarH + _titleScrollView.height);
    }
    contentScrollView.frame = CGRectMake(0, y, self.view.bounds.size.width, height);
    [self.containerView addSubview:contentScrollView];
    _contentScrollView = contentScrollView;
    
    // 设置contentScrollView的属性
    // 分页
    self.contentScrollView.pagingEnabled = YES;
    // 弹簧
    self.contentScrollView.bounces = NO;
    // 指示器
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置代理.目的:监听内容滚动视图 什么时候滚动完成
    self.contentScrollView.delegate = self;
    self.contentScrollView.tag = 888;
}


#pragma mark - Setter & Getter
#pragma mark 添加背景ScrollView
- (PageScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[PageScrollView alloc] initWithFrame:self.view.bounds];
        _bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _bgScrollView.contentInset = UIEdgeInsetsMake(kStatusH + kNavbarH, 0, 0, 0);
        _bgScrollView.delegate = self;
        _bgScrollView.tag = 1;
//        _bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    }
    return _bgScrollView;
}

- (void)setHeader:(UIView *)header{
    if (header) {
        if (_header) {// 避免重复添加
            [_header removeFromSuperview];
        }
        [self.view addSubview:self.bgScrollView];
        [self.bgScrollView addSubview:header];
        self.bgScrollView.headerView = header;
        self.containerView = self.bgScrollView;
        self.bgScrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + header.frame.size.height);
    }
    _header = header;
    
}

@end