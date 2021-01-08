//
//  SetMemberInfoViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import "SetMemberInfoViewController.h"
#import <ImSDK.h>
#import "LiveTool.h"
@interface SetMemberInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *avatar;
@property (weak, nonatomic) IBOutlet UITextField *other;
@property (nonatomic, strong) V2TIMUserFullInfo *info;

@end

@implementation SetMemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[V2TIMManager sharedInstance] getUsersInfo:@[LiveTool.getUserId] succ:^(NSArray<V2TIMUserFullInfo *> *infoList) {
        self.nickname.text = infoList.firstObject.nickName;
        self.avatar.text = infoList.firstObject.faceURL;
    } fail:^(int code, NSString *desc) {
        
    }];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
