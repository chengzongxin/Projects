//
//  IMViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "IMViewController.h"
#import "LiveTool.h"
#import <Masonry/Masonry.h>
#import "DefineHeader.h"
#import "MessageModel.h"
#import "MemberListViewController.h"
#import "SetMemberInfoViewController.h"
#import "IMTool.h"
#import "MessageCell.h"
#import <SDWebImage.h>

@interface IMViewController ()
<
MessageListenerDelegate,
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *customButton;
@property (nonatomic, strong) NSMutableArray <MessageModel *> *messages;
@end

@implementation IMViewController

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [LiveTool getUserId];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SetMember" style:UIBarButtonItemStyleDone target:self action:@selector(setMember)];
    
    [IMTool.shareInstance startWithMsgListener:self];
    
    [self setupSubviews];
}

- (void)setMember{
    [self.navigationController pushViewController:SetMemberInfoViewController.new animated:YES];
}

- (void)setupSubviews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).inset(kSafeAreaBottomInset());
        make.height.mas_equalTo(44);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(height+kSafeAreaBottomInset());
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(kSafeAreaBottomInset());
    }];
}

- (void)customButtonClick:(id)sender{
    [IMTool.shareInstance sendCustomMessage:@{@"thumbup":@1} succ:^{
        NSLog(@"thumbup");
    } fail:^(int code, NSString * _Nonnull desc) {
        NSLog(@"%d,%@",code,desc);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [IMTool.shareInstance sendText:textField.text succ:^{
        NSLog(@"send success!");
        self.title = @"send success!";
        MessageModel *msg = [MessageModel modelWithText:textField.text];
        [self.messages addObject:msg];
        [self.tableView reloadData];
        textField.text = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.title = nil;
        });
    } fail:^(int code, NSString *desc) {
        NSLog(@"send fail! %d,%@",code,desc);
    }];
    [textField resignFirstResponder];
    return YES;
}

/// 收到新消息
- (void)onNewMessage:(MessageModel *)message{
    NSLog(@"onNewMessage");
    [self.messages addObject:message];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MessageCell.class) forIndexPath:indexPath];
    MessageModel *msg = self.messages[indexPath.row];
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:msg.faceUrl]];
    cell.text.text = [NSString stringWithFormat:@"%@: %@",msg.nickName,msg.text];
    return cell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MessageCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(MessageCell.class)];
    }
    return _tableView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.backgroundColor = UIColor.grayColor;
        _textField.delegate = self;
        _textField.rightView = self.customButton;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIButton *)customButton{
    if (!_customButton) {
        _customButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _customButton.frame = CGRectMake(0, 0, 44, 44);
        [_customButton setTitle:@"thumup" forState:UIControlStateNormal];
        [_customButton addTarget:self action:@selector(customButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

- (NSMutableArray<MessageModel *> *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

@end
