//
//  UIImageView+TCategory.m
//  TBasicLib
//
//  Created by kevin.huang on 14-6-26.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "UIImageView+TCategory.h"


@implementation UIImageView (TCategory)

- (void)loadImageWithUrlStr:(NSString *)urlStr placeHolderImage:(UIImage *)img_holder{
    [self setImageWithURL:[NSURL URLWithString:urlStr] placeholder:img_holder];
}

@end
