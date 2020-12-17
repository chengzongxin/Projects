//
//  TMEmptyDefine.h
//  Pods
//
//  Created by nigel.ning on 2020/6/29.
//

#ifndef TMEmptyDefine_h
#define TMEmptyDefine_h
#import <Foundation/Foundation.h>

/// 相关统计整理后的空态页面显的类型值
///@note 以下type值的赋值及定义顺序后续不能修改，否则可能影响对应type下的展示内容
///@warning 因相关内部处理逻辑对展示图片、标题串等数据时，是直接以此type值为数组索引，故：后续不能修改此具体type值的赋值及定义顺序
///@warning 若有其它未定义的内容空态类型，则可均按默认的通用无数据类型处理，对应的图片外部不用关心，相关文案外部可再自行调整
typedef  NS_ENUM(NSInteger, TMEmptyContentType) {
    TMEmptyContentTypeNoData = 0,           ///< 通用的无内容, 这里空空如也
    TMEmptyContentTypeNetErr,               ///<  网络不好或断开
    TMEmptyContentTypeServerErr,            ///<  服务端业务错误
    TMEmptyContentTypeNoCollection,         ///<  收藏夹空空的
    TMEmptyContentTypeNoLike,               ///<  还没有喜欢的内容
    TMEmptyContentTypeNoPublishUgc,         ///<  还没有发布过内容
    TMEmptyContentTypeDataNoExist,          ///<  内容已不存在，通常是已被删除
    TMEmptyContentTypeNoComment,            ///<  还没有评论
    TMEmptyContentTypeNoSearchResult,       ///<  无搜索结果
    TMEmptyContentTypeNoOrder,              ///<  无订单
    
    /// 目前来看，工程内暂无 NoGift 的使用页
    
    TMEmptyContentTypeNoGift,               ///<   还没有获得礼品
    
    ///8.8 新增的特定页面的空态页类型，背景色默认为黑色
    TMEmptyContentTypePhotoDetailErr,       ///< 单张图的效果图详情页接口调用失败后展示的类型
    TMEmptyContentTypeVideoDetailErr,       ///< 单个视频的视频详情页---接口调用失败或视频加载、播放后展示的类型
};

#pragma mark - 其它一些标题、描述串的常量字义

///TMEmptyContentTypeServerErr 类型时，默认为以下文案
///当一些页面为接口调用成功但属于业务范围的错误时，即比如：参数错误等业务错误时 图片可以延用NoData对应的图，而标题及副标题可以用以下定义的建议值，若服务端有返回相关错误信息串，则保留以下title中的显示，将显示的desc替换为服务端接口返回的错误信息串
static NSString *const kTMEmptyViewServerErrTitle = @"服务器开小差了";
static NSString *const kTMEmptyViewServerErrDesc  = @"请稍后再重试";

/// 看别人的个人主页的动态列表页的空态页
static NSString *const kTMEmptyViewOtherFeedEmptyTitle = @"TA还没有动态";
static NSString *const kTMEmptyViewOtherFeedEmptyDesc  = @"去看看其他有趣的动态吧";

///一些列表页筛选操作的后的空态页
static NSString *const kTMEmptyViewFilterCompanyEmptyTitle      = @"暂无符合条件的装修公司";
static NSString *const kTMEmptyViewFilterPrettyImageEmptyTitle  = @"暂无符合条件的效果图";
static NSString *const kTMEmptyViewFilterCaseEmptyTitle         = @"暂无符合条件的整屋案例";
static NSString *const kTMEmptyViewFilterEmptyDesc              = @"没找到呢，换个筛选条件试试";


///用户页若用户已注销则显示的空态页
static NSString *const kTMEmptyViewUserNoExistEmptyTitle        = @"该用户已注销";
static NSString *const kTMEmptyViewUserNoExistEmptyDesc         = @"去看看其他有趣的人吧";


///效果图详情页，若当前仅有一张图数据展示(即不能左右滑动的前提下)，当图片详情接口调用失败后需要展示的特定空态页对应的title. 此时desc默认为nil
static NSString *const kTMEmptyViewPhotoDetailEmptyTitle        = @"加载失败";

///视频详情页，若当前仅有一条视频数据展示(即不能上下滑动的前提下)，当详情接口调用失败后或视频加载、播放失败后展示的特定空态页对应的title，此时desc默认为nil
static NSString *const kTMEmptyViewVideoDetailEmptyTitle        = @"视频加载失败,请稍后再试";

#endif /* TMEmptyDefine_h */
