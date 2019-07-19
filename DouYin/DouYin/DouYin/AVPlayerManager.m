//
//  AVPlayerManager.m
//  DouYin
//
//  Created by Joe on 2019/7/19.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "AVPlayerManager.h"


@interface AVPlayerManager ()

@property (strong, nonatomic) AVPlayerView *playerView0;

@property (strong, nonatomic) AVPlayerView *playerView1;

@property (strong, nonatomic) AVPlayerView *playerView2;

@end

@implementation AVPlayerManager

//单例
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

//初始化
- (instancetype)init {
    self = [super init];
    if(self) {
        _playerView0 = [[AVPlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _playerView1 = [[AVPlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _playerView2 = [[AVPlayerView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    return self;
}

- (void)setUrls:(NSArray<NSString *> *)urls{
    _urls = urls;
}

- (void)playWithIndex:(int)index{
//    NSString *url = self.urls[index];
//    
//    int location = (index % 3);
//    switch (location) {
//        case 0:
//        {
//            [_playerView1 setPlayerUrl:self.urls[index + 1]];
//            [_playerView2 setPlayerUrl:self.urls[index - 1]];
//            
//        }
//            break;
//        case 1:
//        {
//            [_playerView1 setPlayerUrl:self.urls[index - 1]];
//            [_playerView2 setPlayerUrl:self.urls[index - 1]];
//            
//        }
//            break;
//        case 0:
//        {
//            [_playerView2 setPlayerUrl:self.urls[index - 1]];
//            
//        }
//            break;
//    }
}

@end
