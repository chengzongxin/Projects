//
//  CustomConversationListViewController.m
//  RCDemo
//
//  Created by Joe.cheng on 2021/7/1.
//

#import "CustomConversationListViewController.h"
#import "User.h"
@interface CustomConversationListViewController ()

@end

@implementation CustomConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *private = [[UIBarButtonItem alloc] initWithTitle:@"开启单聊" style:UIBarButtonItemStylePlain target:self action:@selector
                                    (private)];
    UIBarButtonItem *group = [[UIBarButtonItem alloc] initWithTitle:@"开启群聊" style:UIBarButtonItemStylePlain target:self action:@selector
                                    (group)];
    self.navigationItem.rightBarButtonItems = @[private,group];
}

- (void)private{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    
    if ([User.sharedInstance.user.ID isEqualToString:User.eren.ID]) {
        conversationVC.targetId = User.mikasa.ID;
    }else{
        conversationVC.targetId = User.eren.ID;
    }
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)group{
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
    conversationVC.conversationType = ConversationType_GROUP;
    conversationVC.targetId = @"1";
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {

    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
    [conversationVC.chatSessionInputBarControl setCommonPhrasesList:@[@"你好", @"不错", @"是这样"]];


    //会话标题
    conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}




@end
