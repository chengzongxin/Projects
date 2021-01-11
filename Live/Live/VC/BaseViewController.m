//
//  BaseViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import "BaseViewController.h"

#define PLAY_URL    @"请输入或扫二维码获取播放地址"
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置推流地址输入、二维码扫描工具栏
    _addressBarController = [[AddressBarController alloc] initWithButtonOption:AddressBarButtonOptionQRScan];
    _addressBarController.qrPresentView = self.view;
    CGFloat topOffset = [UIApplication sharedApplication].statusBarFrame.size.height;
    topOffset += (self.navigationController.navigationBar.frame.size.height + 5);
    _addressBarController.view.frame = CGRectMake(10, topOffset, self.view.frame.size.width-20, 44);
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:15]};
    _addressBarController.view.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:PLAY_URL attributes:dic];
    _addressBarController.delegate = self;
    [self.view addSubview:_addressBarController.view];
}

#pragma mark - AddressBarControllerDelegate

- (void)addressBarControllerTapScanQR:(AddressBarController *)controller {
//    if (_btnPlay.tag == 1) {
//        [self clickPlay:_btnPlay];
//    }
    
    ScanQRController* vc = [[ScanQRController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - ScanQRDelegate

- (void)onScanResult:(NSString *)result {
    _addressBarController.text = result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
//    _cacheStrategyView.hidden = YES;
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
