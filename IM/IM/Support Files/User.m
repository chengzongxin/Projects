//
//  User.m
//  IM
//
//  Created by Joe.cheng on 2021/8/13.
//

#import "User.h"

@implementation User
SHARED_INSTANCE_FOR_CLASS
@dynamic eren,mikasa,armin;
+ (User *)eren{
    User *user = [[User alloc] init];
    user.ID = @"1";
    user.name = @"Eren Yeager";
    user.token = @"qwRsXc799R+iw8iM8R90W1yUPS1yfX1Y@soh8.cn.rongnav.com;soh8.cn.rongcfg.com";
    user.ADID = @"02E347DC-A14F-4EF0-80B7-BABE5318B704"; // my administraor iphonex
    user.portraitUri =  @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201901%2F26%2F20190126013857_wehbc.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631438119&t=04161f515d5b4884bacd9be1901336ed";
    return user;
}

+ (User *)mikasa{
    User *user = [[User alloc] init];
    user.ID = @"2";
    user.name = @"Mikasa Ackerman";
    user.token = @"lR0/nTeDgTSiw8iM8R90WzS+bhX+yf4A@soh8.cn.rongnav.com;soh8.cn.rongcfg.com";
    user.ADID = @"00000000-0000-0000-0000-000000000000";  // iphone 12 pro max simulator
    user.portraitUri =  @"https://img1.baidu.com/it/u=1118508569,1173433835&fm=26&fmt=auto&gp=0.jpg";
    return user;
}

+ (User *)armin{
    User *user = [[User alloc] init];
    user.ID = @"3";
    user.name = @"Armin";
    user.token = @"EwRykzzRErqiw8iM8R90W3k0CvjM9P+B@soh8.cn.rongnav.com;soh8.cn.rongcfg.com";
    user.ADID = @"9AC19E41-FC8E-40B2-919E-8CFD2E32D8E0"; // ning's iphone x
    user.portraitUri =  @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg10.51tietu.net%2Fpic%2F2016-070818%2F201607081812101vvjsd1nx1l.jpg&refer=http%3A%2F%2Fimg10.51tietu.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631442357&t=edac9e15cb92801fbbb27a4883d63ec2";
    return user;
}

- (RCUserInfo *)rcUser{
    return [[RCUserInfo alloc] initWithUserId:self.ID name:self.name portrait:self.portraitUri];
}

- (NSString *)description{
    NSString *des = [super description];
    return [NSString stringWithFormat:@"%@ - <%@> - <%@>",des,self.ID,self.name];
}

@end
