//
//  CustomConversationListViewController.m
//  RCDemo
//
//  Created by Joe.cheng on 2021/7/1.
//

#import "CustomConversationListViewController.h"

@interface CustomConversationListViewController ()

@end

@implementation CustomConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"开启单聊" style:UIBarButtonItemStylePlain target:self action:@selector
                                    (rightBarButtonItemPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)rightBarButtonItemPressed:(id)sender {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = @"888";
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
