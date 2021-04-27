//
//  THKAvatarViewModel.m
//  HouseKeeper
//
//  Created by Joe.cheng on 2021/2/7.
//  Copyright © 2021 binxun. All rights reserved.
//

#import "THKAvatarViewModel.h"

@implementation THKAvatarViewModel

- (instancetype)initWithAvatarUrl:(NSString *)avatarUrl identityType:(NSInteger)identityType{
    return [self initWithAvatarUrl:avatarUrl placeHolderImage:nil identityType:identityType identitySubType:0];
}

- (instancetype)initWithAvatarUrl:(NSString *)avatarUrl placeHolderImage:(UIImage *)placeHolderImage identityType:(NSInteger)identityType identitySubType:(NSInteger)identitySubType{
    if (self == [super init]) {
        self.avatarUrl = avatarUrl;
        self.placeHolderImage = placeHolderImage;
        self.identityType = identityType;
        self.identitySubType = identitySubType;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.avatarUrl = nil;
        self.placeHolderImage = kDefaultHeadImg;
        self.identityType = 0;
        self.identitySubType = 0;
        self.onTapSubject = RACSubject.subject;
        self.identityIconSize = CGSizeMake(10, 10);
        self.identityIconCenterOffset = CGPointZero;
        self.onTapSubject = RACSubject.subject;
    }
    return self;
}

@end
