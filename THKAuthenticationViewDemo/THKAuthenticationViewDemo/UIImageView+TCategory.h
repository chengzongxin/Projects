//
//  UIImageView+TCategory.h
//  TBasicLib
//
//  Created by kevin.huang on 14-6-26.
//  Copyright (c) 2014年 binxun. All rights reserved.
//  封装常用加载图片方式

#import <UIKit/UIKit.h>
#import <YYKit.h>
#import <Masonry.h>

@interface UIImageView (TCategory)


@property (nonatomic, assign) NSInteger tmp_reuseFlag;///< 默认为0 当为1时表示此imageView可能会被复用，在快速滑动过程中若处于复用情况下，加载进度视图只有在stage为finish的情况下才会执行hide操作，当前留标记用作效果图沉浸式浏览页单独的逻辑(后续需要观察增加这个stage==finish才hide的逻辑是否对其它有展示加载进度的地方有影响)

/*
 以下加载网络图片方法统一说明：
 根据链接获取图片 缓存到本地，默认为cach目录，有缓存直接显示无需请求网络
 参数：
 urlStr  图片地址
 ablock 加载完成后调用的模块
 img_holder 图片未加载完成显示的默认图片
 */

- (void)loadImageWithUrlStr:(NSString *)urlStr
           placeHolderImage:(UIImage *)img_holder;

@end
