//
//  ViewController.m
//  讯飞语音Demo
//
//  Created by Joe on 2019/7/9.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "ViewController.h"
#import <iflyMSC/iflyMSC.h>


@interface ViewController ()<IFlySpeechRecognizerDelegate,IFlySpeechSynthesizerDelegate>
//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建语音识别对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    //设置识别参数
    //设置为听写模式
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}

- (void)recognizeAudio{
    //设置音频源为音频流（-1）
    [self.iFlySpeechRecognizer setParameter:@"-1" forKey:@"audio_source"];
    
    //启动识别服务
    [self.iFlySpeechRecognizer startListening];
    
    //写入音频数据
    NSString *audio_file = @"";
    NSData *data = [NSData dataWithContentsOfFile:audio_file];    //从文件中读取音频
    [self.iFlySpeechRecognizer writeAudio:data];//写入音频，让SDK识别。建议将音频数据分段写入。
    
    //音频写入结束或出错时，必须调用结束识别接口
    [self.iFlySpeechRecognizer stopListening];//音频数据写入完成，进入等待状态
}

- (IBAction)start:(id)sender {
    //启动识别服务
    [_iFlySpeechRecognizer startListening];
}


- (IBAction)stop:(id)sender {
    [_iFlySpeechRecognizer stopListening];
}

- (IBAction)startRecord:(id)sender {
    [self recognizeAudio];
}

- (IBAction)audioComplex:(id)sender {
    if (!_iFlySpeechSynthesizer) {
        //获取语音合成单例
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        //设置协议委托对象
        _iFlySpeechSynthesizer.delegate = self;
        //设置合成参数
        //设置在线工作方式
        [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
        //设置音量，取值范围 0~100
        [_iFlySpeechSynthesizer setParameter:@"50"
                                      forKey: [IFlySpeechConstant VOLUME]];
        //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
        [_iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                      forKey: [IFlySpeechConstant VOICE_NAME]];
        //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
        [_iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                      forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    }
    //启动合成会话
    [_iFlySpeechSynthesizer startSpeaking:self.textView.text];
}


//IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSLog(@"%s",__FUNCTION__);
}
//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    NSLog(@"%s",__FUNCTION__);
}
//停止录音回调
- (void) onEndOfSpeech{
    NSLog(@"%s",__FUNCTION__);
}
//开始录音回调
- (void) onBeginOfSpeech{
    NSLog(@"%s",__FUNCTION__);
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
    NSLog(@"%s",__FUNCTION__);
}
//会话取消回调
- (void) onCancel{
    NSLog(@"%s",__FUNCTION__);
}


//IFlySpeechSynthesizerDelegate协议实现
//合成结束
//- (void) onCompleted:(IFlySpeechError *) error {
//    NSLog(@"%s",__FUNCTION__);
//}
//合成开始
- (void) onSpeakBegin {
    NSLog(@"%s",__FUNCTION__);
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {
    NSLog(@"%s",__FUNCTION__);
}
//合成播放进度
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos {
    NSLog(@"%s",__FUNCTION__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
