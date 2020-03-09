//
//  ChooseSymbolView.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/3/9.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "ChooseSymbolView.h"
#import "ChooseSymbolCell.h"

@interface ChooseSymbolView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ChooseSymbolView

- (void)dealloc{
    NSLog(@"dealloc -- %@",self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self removeFromSuperview];
        });
    }];
    
}

- (void)setupViews{
    self.backgroundColor = [UIColor colorWithRed:9/255.0 green:10/255.0 blue:21/255.0 alpha:0.7];
//    self.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    [self addGestureRecognizer:tap];
    
    [self addSubview:self.tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseSymbolCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ChooseSymbolCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 66)];
    view.backgroundColor = UIColor.whiteColor;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake((self.bounds.size.width-40)/2,10,40,4);
    line.layer.backgroundColor = [UIColor colorWithRed:191/255.0 green:200/255.0 blue:218/255.0 alpha:1.0].CGColor;
    line.layer.cornerRadius = 2;
    [view addSubview:line];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,34,self.bounds.size.width,20);
    label.text = @"选择币种";
    label.textColor = [UIColor colorWithRed:45/255.0 green:51/255.0 blue:68/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < -180) {
        [self dismiss];
    }else if (scrollView.contentOffset.y < 0) {
//        scrollView.transform = CGAffineTransformTranslate(scrollView.transform, 0, -scrollView.contentOffset.y);
        scrollView.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y);
    }
}

#pragma mark - Getter
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 211, self.bounds.size.width, self.bounds.size.height - 211);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor colorWithRed:246/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layer.cornerRadius = 12;
        _tableView.layer.masksToBounds = YES;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ChooseSymbolCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ChooseSymbolCell.class)];
    }
    return _tableView;
}

@end
