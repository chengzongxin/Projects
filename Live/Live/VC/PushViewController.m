//
//  ViewController.m
//  Live
//
//  Created by Joe.cheng on 2021/1/6.
//

#import "PushViewController.h"
#import "TXLiteAVSDK_Professional/TXLiteAVSDK.h"
#import "LiveConst.h"
@interface PushViewController ()

@property (nonatomic, strong) TXLivePushConfig *config;
@property (nonatomic, strong) TXLivePush *pusher;
@property (nonatomic, strong) UIView *localView;

@end

@implementation PushViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"viewdidload");
    // 3. 初始化 TXLivePush 组件
    _config = [[TXLivePushConfig alloc] init];  // 一般情况下不需要修改默认 config
    _pusher = [[TXLivePush alloc] initWithConfig: _config]; // config 参数不能为空
    
    // 4. 开启摄像头预览
    //创建一个 view 对象，并将其嵌入到当前界面中
    _localView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:_localView atIndex:0];
    _localView.center = self.view.center;
    //启动本地摄像头预览
    [_pusher startPreview:_localView];
    
    // 5. 启动和结束推流
    //启动推流
    NSString* rtmpUrl = pushRtmpUrl;   //此处填写您的 rtmp 推流地址
    [_pusher startPush:rtmpUrl];
    
    //结束推流
    //    [_pusher stopPreview]; //如果已经启动了摄像头预览，请在结束推流时将其关闭。
    //    [_pusher stopPush];
}


@end
