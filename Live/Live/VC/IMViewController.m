//
//  IMViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "IMViewController.h"
#import "LiveConst.h"
#import <ImSDK.h>
#import "GenerateTestUserSig.h"
#import "LiveTool.h"
#import <Masonry/Masonry.h>
#import "DefineHeader.h"

@interface IMViewController ()
<
V2TIMSDKListener,
V2TIMGroupListener,
V2TIMSimpleMsgListener,
V2TIMAdvancedMsgListener,
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray <V2TIMMessage *> *msgs;
@end

@implementation IMViewController

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSDK];
    
    [self setupSubviews];
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

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(height+kSafeAreaBottomInset());
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset(kSafeAreaBottomInset());
    }];
}


- (void)initSDK{
    
    
    self.title = [LiveTool getUserId];
    // 1. 从 IM 控制台获取应用 SDKAppID，详情请参考 SDKAppID。
    // 2. 初始化 config 对象
    V2TIMSDKConfig *config = [[V2TIMSDKConfig alloc] init];
    // 3. 指定 log 输出级别，详情请参考 [SDKConfig](#SDKAppID)。
    config.logLevel = V2TIM_LOG_INFO;
    // 4. 初始化 SDK 并设置 V2TIMSDKListener 的监听对象。
    // initSDK 后 SDK 会自动连接网络，网络连接状态可以在 V2TIMSDKListener 回调里面监听。
    [[V2TIMManager sharedInstance] initSDK:SDKAppID config:config listener:self];
    
}

// 5. 监听 V2TIMSDKListener 回调
- (void)onConnecting {
    // 正在连接到腾讯云服务器
    NSLog(@"onConnecting");
}
- (void)onConnectSuccess {
    // 已经成功连接到腾讯云服务器
    NSLog(@"%s",__func__);
    NSString *userId = [LiveTool getUserId];
    NSString *userSig = [GenerateTestUserSig genTestUserSig:userId];
    [[V2TIMManager sharedInstance] login:userId userSig:userSig succ:^{
        NSLog(@"login success");
        [[V2TIMManager sharedInstance] setGroupListener:self];
        if ([[LiveTool getUserId] containsString:@"593a4d"]) {
            // simulator
            [self createGroup];
        }else{
            [self joinGroup];
        }
    } fail:^(int code, NSString *desc) {
        NSLog(@"login fail code = %d,desc = %@",code,desc);
    }];
}
- (void)onConnectFailed:(int)code err:(NSString*)err {
    // 连接腾讯云服务器失败
    NSLog(@"%s,code = %d,err = %@",__func__,code,err);
}

// succ 881122
- (void)createGroup{
    // 示例代码：使用高级版 createGroup 创建一个工作群
    V2TIMGroupInfo *info = [[V2TIMGroupInfo alloc] init];
    info.groupID = [LiveTool getGroupId];
    info.groupName = @"LiveRoom";
    info.groupType = @"AVChatRoom";
//    NSMutableArray *memberList = [NSMutableArray array];
//    V2TIMCreateGroupMemberInfo *memberInfo = [[V2TIMCreateGroupMemberInfo alloc] init];
//    memberInfo.userID = [LiveTool getUserId];
//    [memberList addObject:memberInfo];
    [[V2TIMManager sharedInstance] createGroup:info memberList:nil succ:^(NSString *groupID) {
      // 创建群组成功
        NSLog(@"succ groupID = %@",groupID);
        [self addGroupMsgLister];
    } fail:^(int code, NSString *msg) {
      // 创建群组失败
        NSLog(@"fail code = %d,msg =%@",code,msg);
        // fail code = 10025,msg =group id has be used by youself!
        if (code == 10025) {
            [self joinGroup];
        }
    }];
}

- (void)joinGroup{
    [[V2TIMManager sharedInstance] joinGroup:[LiveTool getGroupId] msg:@"" succ:^{
        NSLog(@"join group succ");
        [self addGroupMsgLister];
    } fail:^(int code, NSString *desc) {
        NSLog(@"fail join group code = %d,msg =%@",code,desc);
    }];
}

- (void)addGroupMsgLister{
    [[V2TIMManager sharedInstance] addSimpleMsgListener:self];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
}

- (void)onMemberEnter:(NSString *)groupID memberList:(NSArray<V2TIMGroupMemberInfo *> *)memberList{
    NSLog(@"onMemberEnter %@,%@",groupID,memberList);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[V2TIMManager sharedInstance] sendGroupTextMessage:textField.text to:[LiveTool getGroupId] priority:V2TIM_PRIORITY_DEFAULT succ:^{
        NSLog(@"send success!");
        self.title = @"send success!";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.title = nil;
        });
    } fail:^(int code, NSString *desc) {
        NSLog(@"send fail! %d,%@",code,desc);
    }];
    [textField resignFirstResponder];
    return YES;
}

/// 收到群文本消息
- (void)onRecvGroupTextMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info text:(NSString *)text{
    NSLog(@"onRecvGroupTextMessage");
}

/// 收到群自定义（信令）消息
- (void)onRecvGroupCustomMessage:(NSString *)msgID groupID:(NSString *)groupID sender:(V2TIMGroupMemberInfo *)info customData:(NSData *)data{
    NSLog(@"onRecvGroupCustomMessage");
}

/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSLog(@"onRecvNewMessage");
    [self.msgs addObject:msg];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    V2TIMMessage *msg = self.msgs[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ by :%@",msg.textElem.text,msg.sender];
    return cell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    return _tableView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.backgroundColor = UIColor.grayColor;
        _textField.delegate = self;
    }
    return _textField;
}

- (NSMutableArray<V2TIMMessage *> *)msgs{
    if (!_msgs) {
        _msgs = [NSMutableArray array];
    }
    return _msgs;
}

@end
