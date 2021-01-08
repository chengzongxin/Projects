//
//  SetMemberInfoViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "SetMemberInfoViewController.h"
#import <ImSDK.h>
#import "LiveTool.h"
#import "User.h"
@interface SetMemberInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *avatar;
@property (weak, nonatomic) IBOutlet UITextField *other;
@property (nonatomic, strong) V2TIMUserFullInfo *info;

@end

@implementation SetMemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nickname.text = User.shareInstance.nickName;
    self.avatar.text = User.shareInstance.faceUrl;
}
- (IBAction)confirm:(id)sender {
    V2TIMUserFullInfo *info = [[V2TIMUserFullInfo alloc] init];
    info.nickName = self.nickname.text;
    info.faceURL = self.avatar.text;
    [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(int code, NSString *desc) {
        NSLog(@"%d,%@",code,desc);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
