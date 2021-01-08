//
//  SetMemberViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "MemberListViewController.h"
#import <ImSDK.h>
#import "LiveTool.h"
#import "SetMemberInfoViewController.h"
@interface MemberListViewController ()<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <V2TIMGroupMemberFullInfo *>*memberList;
@end

@implementation MemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
//    [[V2TIMManager sharedInstance] getGroupMembersInfo:LiveTool.getGroupId memberList:nil succ:^(NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
//
//    } fail:^(int code, NSString *desc) {
//
//    }];
    
    [[V2TIMManager sharedInstance] getGroupMemberList:[LiveTool getGroupId] filter:V2TIM_GROUP_MEMBER_FILTER_ALL nextSeq:0 succ:^(uint64_t nextSeq, NSArray<V2TIMGroupMemberFullInfo *> *memberList) {
        self.memberList = memberList;
        [self.tableView reloadData];
    } fail:^(int code, NSString *desc) {
        NSLog(@"getGroupMemberList fail %d,%@",code,desc);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    V2TIMGroupMemberFullInfo *member = self.memberList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",member.customInfo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:SetMemberInfoViewController.new animated:YES];
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

@end
