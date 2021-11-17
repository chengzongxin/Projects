//
//  THKComonDefine.h
//  HouseKeeper
//
//  Created by kevin.huang on 14-7-21.
//  Copyright (c) 2014年 binxun. All rights reserved.
//  项目级公共宏或数据、函数

#ifndef HouseKeeper_THKComonDefine_h
#define HouseKeeper_THKComonDefine_h

//#import "THKTrackUploadRequest.h"
#pragma mark - Color

#define kDefaultBackGroundColor [UIColor colorWithHexString:@"#eeeeee"]//RGB_255(234, 234, 234)

#define kBlackTextColor [UIColor colorWithHexString:@"#666"]
#define kGrayTextColor [UIColor colorWithHexString:@"#ccc"]
#define kPlaceholderColor [UIColor colorWithHexString:@"#c7c7c7"]
#define kCommonColor_999 [UIColor colorWithHexString:@"#999999"]
#define kCommonColor_333 [UIColor colorWithHexString:@"#333333"]
#define kCommonColor_444 [UIColor colorWithHexString:@"#444444"]
#define kCommonColor_warning [UIColor colorWithHexString:@"#f39724"]

//常用颜色
#define kCommonColor_1 [UIColor colorWithHexString:@"#000000"]
#define kCommonColor_2 [UIColor colorWithHexString:@"#666666"]
#define kCommonColor_3 [UIColor colorWithHexString:@"#999999"]
#define kCommonColor_4 [UIColor colorWithHexString:@"#c7c7c7"]
#define kCommonColor_6 [UIColor colorWithHexString:@"#5c6368"]
#define kCommonColor_7 [UIColor colorWithHexString:@"#ff8a00"]
#define kCommonColor_8 kTo8toGreen
#define kCommonColor_9 [UIColor colorWithHexString:@"#8e8e93"]
#define kCommonColorIsOff [UIColor colorWithHexString:@"#b9bbbd"]

#define kCommonColor_ff8a00 [UIColor colorWithHexString:@"#ff8a00"]
#define kCommonColor_caccd0 [UIColor colorWithHexString:@"#caccd0"]
#define kCommonColor_13b66f [UIColor colorWithHexString:@"#13b66f"]
#define kCommonColor_d6d6e0 [UIColor colorWithHexString:@"#d6d6e0"]
#define kCommonColor_c1c1c1 [UIColor colorWithHexString:@"#c1c1c1"]
#define kCommonColor_ffffff [UIColor colorWithHexString:@"#ffffff"]
#define kCommonColor_ffb200 [UIColor colorWithHexString:@"#ffb200"]
//常用字体
#define kCommonFont_T18 [UIFont systemFontOfSize:9]
#define kCommonFont_T21 [UIFont systemFontOfSize:10.5]
#define kCommonFont_T22 [UIFont systemFontOfSize:11]
#define kCommonFont_T24 [UIFont systemFontOfSize:12]
#define kCommonFont_T26 [UIFont systemFontOfSize:13]
#define kCommonFont_T28 [UIFont systemFontOfSize:14]
#define kCommonFont_T30 [UIFont systemFontOfSize:15]
#define kCommonFont_T32 [UIFont systemFontOfSize:16]
#define kCommonFont_T34 [UIFont systemFontOfSize:17]
#define kCommonFont_T36 [UIFont systemFontOfSize:18]
#define kCommonFont_T38 [UIFont systemFontOfSize:19]
#define kCommonFont_T40 [UIFont systemFontOfSize:20]
#define kCommonFont_T48 [UIFont systemFontOfSize:24]
#define kCommonFont_T50 [UIFont systemFontOfSize:25]
#define kCommonFont_T70 [UIFont systemFontOfSize:35]

//常用字体的字号
#define kCommonFontSize_T21 10.5
#define kCommonFontSize_T24 12
#define kCommonFontSize_T28 14
#define kCommonFontSize_T32 16
#define kCommonFontSize_T38 19
#define kCommonFontSize_T40 20

//常用行间距
#define kCommonLineGap_T28_34 6/2
#define kCommonLineGap_T32_40 8/2
#define kCommonLineGap_T38_48 10/2
#define kCommonLineGap_T24_36 12/2
#define kCommonLineGap_T28_40 (12/2-2)
#define kCommonLineGap_T32_50 18/2

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


//两种常用线条颜色值
#define kLineColor [UIColor colorWithHexString:@"#e3e3e3"] //白底上的线条
#define kLineColor_gray [UIColor colorWithHexString:@"#d8d8d8"] //灰底上的线条

static NSString *kGEAppWidgetShow  = @"appWidgetShow";
static NSString *kGEAppWidgetClick = @"appWidgetClick";

static CGFloat kAlertAlpha = 0.7;

//保存用户装修时间戳
#define kKeyOfUserFinishTime @"com.to8to.userProcessChangeTime"
//首页刷新通知
#define kHomeNotRefresh @"homeNotRefresh"

#define kClearImg [UIImage imageNamed:@"bg_clearImg"]

#define THKUserLocationDidUpdateNotification @"THKUserLocationDidUpdateNotification"

#define THKDidRegisterDeviceTokenNotification @"THKDidRegisterDeviceTokenNotification"

#define THKDidReceiveRemoteNotification @"THKDidReceiveRemoteNotification"

#define THKReloadMyHomeOrProjectProcessNodesMessageNotification @"THKReloadMyHomeOrProjectProcessNodesMessageNotification"

#define THKReloadContractListNotification @"THKReloadContractListNotification"

#define THKAgreePayNotification @"THKAgreePayNotification"

#define THKAttentionTopicNotification @"THKAttentionTopicNotification"

#define TPLNAttentionNotification @"TPLNAttentionNotification"

///v8.8.0 直播间完成任务时触发底部动效
#define kLiveRoomTaskAnimationNotification @"LiveRoomTaskAnimationNotification"
/**
 如果未登录时收到即时红包后发出通知，在线观众列表收到这个通知后需要隐藏自己
 */
#define kLiveRoomImmediateRedPacketNotification @"LiveRoomImmediateRedPacketNotification"

///< 7.3版调整消息中心到消息中心Tab,此通知用于通知消息中心tab即时拉取接口并更新数字
#define kNotice_UnReadMsgCountOfIconNeedUpdate @"kNotice_UnReadMsgCountOfIconNeedUpdate"

//非头像默认图片 小图
#define kDefaultImg_small kClearImg
//非头像默认图片 大图
#define kDefaultImg_big kClearImg
//默认图片的默认背景颜色
#define kDefaultImgBgColor [UIColor colorWithHexString:@"eaeaea"]


//四种尺寸的默认头像
#define kDefaultHeadPortrait_60  [UIImage imageNamed:@"ico_headPortrait_60"]
#define kDefaultHeadPortrait_88  [UIImage imageNamed:@"ico_headPortrait_88"]
#define kDefaultHeadPortrait_100 [UIImage imageNamed:@"ico_headPortrait_100"]
#define kDefaultHeadPortrait_162 [UIImage imageNamed:@"ico_headPortrait_162"]
#define kHomeDefaultHeader       [UIImage imageNamed:@"home_default_header"]

#define kDefaultLineGap 6



typedef enum : NSInteger {
    kSearchType_company = 0,
    kSearchType_infocompany = 1,
    kSearchType_infoconmunity = 2,
    kSearchType_know = 3,
    kSearchType_pictureLibrary = 4,
    kSearchType_pictureNew = 5,//6.1版本图库
}kSearchType;

typedef enum:NSInteger {
    kDesignerTeam = 1,//设计师
    kWorkerTeam = 2,  //工人
}kComTeamType;

typedef NS_ENUM(NSInteger,THKBizLoadStatus){
    ///成功
    THKBizLoadStatusSuccess       = 1,
    
    ///数据为空
    THKBizLoadStatusEmpty         = 2,
    
    ///服务器错误
    THKBizLoadStatusServiceError  = 3,
    
    ///网路错误
    THKBizLoadStatusNetworkError  = 4,
};

/**
 *  判断字符串是否为空
 *
 *  @param string 输入的字符串
 *
 *  @return YES,为空；NO,不为空
 */
NS_INLINE BOOL k_IsBlankString(NSString *string){
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#define kNoSelectedComId -100 //还没有选择装修公司的id
#define kNoSelectedComName @"还没有选好装修公司"

#define kWeixinPaySuccessNoti @"kWeixinPaySuccessNoti"
#define kResetPwdSuccessNoti @"kResetPwdSuccessNoti"

//最小昵称长度
static NSInteger kMinLengthOfNick = 1;
//最大昵称长度
static NSInteger kMaxLengthOfNick = 15;

//static NSString *const kImgNameOfCellArrow = @"btn_content_arrow_right_gray";
//NS_INLINE void kSetArrowForCell(UITableViewCell *cell){
//    cell.accessoryView = [[UIImageView alloc]initWithImage:kImgAtBundle(kImgNameOfCellArrow)];
//    cell.accessoryView.clipsToBounds = YES;
//}

/**
 *
 *  判断字符串是否全部是数字
 *
 *  @param string 输入字符串
 *
 *  @return YES 是,NO 不是
 */
NS_INLINE BOOL k_IsAllNum(NSString *string){
    if (k_IsBlankString(string)) {
        return NO;
    }
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

//验证密码 移至pod?
NS_INLINE BOOL kCheckPassWord(NSString *_text)
{
    NSString *passwordRegex = @"^(?![0-9]+$)(?![,.#%'+*:;^_`-]+$)(?![a-zA-Z]+$)[0-9A-Za-z,.#%'+*:;^_`-]{8,}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:_text];
}


typedef id (^T8TReturnObjectBlock)(void);

NS_INLINE CGFloat kSafeAreaTopInset(){
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
        top = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
    }
    return top;
}

NS_INLINE CGFloat kSafeAreaBottomInset(){
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.bottom;
    }
    return bottom;
}

NS_INLINE CGFloat kTNavigationBarHeight(){
    static CGFloat navHeight = 0;
    if (navHeight > 0) {
        return navHeight;
    }
    navHeight = 64;
    if (@available(iOS 11.0, *)) {
        CGFloat top = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
        navHeight = top > 0 ? UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top + 44 : 64;
    }
    return navHeight;
}

static inline NSString* t_jsonString(NSObject *obj)
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:0
                                                         error:nil];
    if (jsonData && jsonData.length > 0) {
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return str;
    }
    return nil;
}

/**
 safeAreaInset版本判断
 @return 返回当前view的safeAreaInset
 */
static inline UIEdgeInsets fw_safeAreaInset() {
    if (@available(iOS 11.0, *)) {
        if (UIApplication.sharedApplication.windows.firstObject.rootViewController.view != nil) {
            return UIApplication.sharedApplication.windows.firstObject.rootViewController.view.safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}

//是否iPhoneX以上机型
#define isIphoneXAscending (^BOOL(){if (@available(iOS 11.0, *)) {return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom>0;} return NO;}())


/**
 查IM名称，顺序nickname->realname->name
 **/
static NSString *cl_getMemberName(NSDictionary *dict)
{
    NSString *rName = nil;
    if ([dict[@"accountName"] length]) {
        rName = dict[@"accountName"];
    }
    else if ([dict[@"nickname"] length]) {
        rName = dict[@"nickname"];
    }
    else if ([dict[@"realName"] length]) {
        rName = dict[@"realName"];
    }
    else if ([dict[@"name"] length]) {
        rName = dict[@"name"];
    }
    return rName;
}

static inline UIViewController *vcForView(UIResponder *v)
{
    while (![v isKindOfClass:[UIViewController class]]) {
        v = v.nextResponder;
    }
    return (UIViewController *)v;
}

static inline UIImage* imageWithColor(UIColor *clr)
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [clr CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//static inline NSArray* getTownsForCity(NSString *cityName)
//{
//    NSString *areaFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/allAreas.plist"];
//    NSArray* (^getTowns)(NSString *) = ^NSArray*(NSString *cityName){
//        NSArray *lst = [NSKeyedUnarchiver unarchiveObjectWithFile:areaFilePath];
//        for (NSDictionary *dict in lst) {
//            if ([dict[@"cityName"] isEqualToString:cityName]) {
//                return dict[@"children"];
//            }
//        }
//        return nil;
//    };
//    NSArray *towns = getTowns([TLocationManager getCityName]);
//    return towns;
//}
//
//static inline void uploadTrack(NSString *bizId,NSString *bizType,NSString *title,NSString *referId)
//{
//    if ([bizType isEqualToString:@"b0032"]) {
//        bizType = @"b0016";
//    }
//    else if ([bizType isEqualToString:@"b0033"]) {
//        bizType = @"b0027";
//    }
//    [THKTrackUploadRequest uploadWithBizType:bizType bizId:bizId title:title referId:referId];
//}

#define T_CREATE_SHARED_INSTANCE(CLASS_NAME) \
+ (instancetype)sharedInstance { \
static CLASS_NAME *_instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[CLASS_NAME alloc] init]; \
}); \
\
return _instance; \
}

#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])

//当一些方法需要子类进行具体实现的时候可能在父里方法里调用以下宏，子类方法不能调super
#define Method_NotImplementation_Assert(_cmd, self) \
NSAssert2(NO, @"method %@ need complete by subClass: %@", NSStringFromSelector(_cmd), NSStringFromClass(self.class)); \



#endif
