//
//  ChoiceCoinViewController.m
//  MatafyInterDemo
//
//  Created by Joe on 2020/1/14.
//  Copyright © 2020 Joe. All rights reserved.
//

#import "ChoiceCoinViewController.h"
#import "SearchTextField.h"
#import "CoinChoiceCell.h"

@interface ChoiceCoinViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) SearchTextField *textField;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ChoiceCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:249/255.0 alpha:1.0];
    self.title = @"币种选择";
    
    [self.view addSubview:self.textField];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Delegate
#pragma mark TextField delegate
// MARK: 输入事件
- (void)textDidChange:(UITextField *)textField{
    //    NSLog(@"%@",textField.text);
    
    if (textField.markedTextRange == nil)//点击完选中的字之后
    {
        NSLog(@"text:%@", textField.text);
        // 截取空格
        NSString *content = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (content.length == 0) {
            // 展示默认页面
//            [self showInialView];
        }else{
            // 加载数据
            //            [self loadSearchData:content];
        }
    }
    else//没有点击出现的汉字,一直在点击键盘
    {
        NSLog(@"markedTextRange:%@",textField.text);
    }
}

#pragma mark UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoinChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoinChoiceCell class])];
    return cell;
}

#pragma mark - Setter & Getter
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = CGRectMake(15, CGRectGetMaxY(self.textField.frame) + 13, self.view.bounds.size.width - 15*2, 455);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 18, 0, 18);
        _tableView.separatorColor = [UIColor colorWithRed:246/255.0 green:248/255.0 blue:249/255.0 alpha:1.0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 64;
        // UITableViewStyleGrouped headerView占据35高度
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        // 自适应内容边距
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        // 隐藏下面多出来的cell
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CoinChoiceCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CoinChoiceCell class])];
    }
    return _tableView;
}


- (SearchTextField *)textField{
    if (!_textField) {
        // searchText
        CGFloat y = self.navigationController.navigationBar.frame.size.height + UIApplication.sharedApplication.statusBarFrame.size.height + 15;
        _textField = [[SearchTextField alloc] initWithFrame:CGRectMake(15, y, self.view.bounds.size.width - 15*2, 48)];
        _textField.backgroundColor = UIColor.whiteColor;
        _textField.layer.cornerRadius = 4;
        _textField.layer.masksToBounds = YES;
        _textField.font = [UIFont systemFontOfSize:14];
        // 修改placeholder属性
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"试试搜索“香港中环最便宜的五星级酒店”" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor colorWithRed:189/255.0 green:198/255.0 blue:211/255.0 alpha:1.0],
                                            NSFontAttributeName:_textField.font
                                            }];
        _textField.attributedPlaceholder = attrString;
        _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coin_编组"]];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.clearsOnBeginEditing = NO;
        [_textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}


@end
