//
//  THKColorsDefine.h
//  HouseKeeper
//
//  Created by nigel.ning on 2019/10/11.
//  Copyright © 2019 binxun. All rights reserved.
//

#ifndef THKColorsDefine_h
#define THKColorsDefine_h

#import <Foundation/Foundation.h>
#import "UIColor+HexString.h"

///MARK: 统一整理工程几种常用显示的颜色定义,参考UI设计给的颜色规范（参加：http://wiki.we.com:8090/pages/viewpage.action?pageId=71678928）。
///MARK:【注意】:以下定义并不表示工程里用到的颜色只有以下几种，以下仅为几种常见的通用颜色定义。
///MARK:【注意】:以下宏定义名仅为按照UI出的常用标准色规范里的描述近义翻译为英文描述名，实际使用时仅表示多数情况下对应组件使用相应的颜色，但不是绝对，根据实际情况灵活使用即可。

///MARK: 主色调

/** 小面积使用，用于特别需要强调的文字、按钮和图标 */
#define THKColor_MainColor                      _THKColorWithHexString(@"24C77E")

/** 按下色 浅色背景下强调主色使用 */
#define THKColor_MainAccentColor                _THKColorWithHexString(@"01AA64")

/** v8.10 样式调整首页改版-涉及卡片组件样式效果调整，重新定义瀑布流列表页背景色值(原为默认白色) */
#define THKColor_FlowListBackgroundColor      _THKColorWithHexString(@"F8FAFC")

///MARK: 文本色

/** 用于重要级文字信息，页内标题信息 */
#define THKColor_TextImportantColor             _THKColorWithHexString(@"111111")

/** 用于一般文字信息，正文或常规文字 */
#define THKColor_TextRegularColor               _THKColorWithHexString(@"5F6277")

/** 用于辅助、次要、弱提示类的文字信息 */
#define THKColor_TextWeakColor                  _THKColorWithHexString(@"878B99")

/** 用于占位文字 */
#define THKColor_TextPlaceHolderColor           _THKColorWithHexString(@"CBCDD4")

/** 浅深红色 */
#define THKColor_WeakDeepRedColor               _THKColorWithHexString(@"FA5555")


///MARK: 辅助色

/** 用于页面中的分割线和边框色 */
#define THKColor_Sub_SeparatorAndBorderColor    _THKColorWithHexString(@"EBECF5")

/** 用于选项类、按钮类颜色 */
#define THKColor_Sub_OptionsColor               _THKColorWithHexString(@"F0F1F5")

/** 用于页面空白区域底色 */
#define THKColor_Sub_EmptyAreaBackgroundColor   _THKColorWithHexString(@"F5F7FA")

/** 警告类、消息数提示色-浅红色 */
#define THKColor_Sub_CautionColor               _THKColorWithHexString(@"FE6969")
#define THKColor_WarningAndTipsColor            _THKColorWithHexString(@"FF4C5B")

/** 背景色 */
#define THKColor_MainView_BackgroundColor       _THKColorWithHexString(@"FFFFFF")

/** 导航栏底部分隔线颜色 */
#define THKColor_Nav_BottomLineColor            THKColor_Sub_SeparatorAndBorderColor

///MARK: 部分工程中用的相对较频繁的其它色值定义整理
///MARK: 工程里用的其它颜色宏参考： THKComonDefine.h， 后续可考虑整合此两处的颜色值的宏定义

#define THKColor_8E8E93         _THKColorWithHexString(@"8E8E93")
#define THKColor_222222         _THKColorWithHexString(@"222222")
#define THKColor_333333         _THKColorWithHexString(@"333333")
#define THKColor_444444         _THKColorWithHexString(@"444444")
#define THKColor_666666         _THKColorWithHexString(@"666666")
#define THKColor_999999         _THKColorWithHexString(@"999999")
#define THKColor_CCCCCC         _THKColorWithHexString(@"CCCCCC")
#define THKColor_C1C1C1         _THKColorWithHexString(@"C1C1C1")
#define THKColor_E5E5E5         _THKColorWithHexString(@"E5E5E5")
#define THKColor_EEEEEE         _THKColorWithHexString(@"EEEEEE")
#define THKColor_E3E3E3         _THKColorWithHexString(@"E3E3E3")
#define THKColor_F4F4F4         _THKColorWithHexString(@"F4F4F4")
#define THKColor_FFFFFF         _THKColorWithHexString(@"FFFFFF")
#define THKColor_34C083         _THKColorWithHexString(@"34C083")
#define THKColor_BABDC6         _THKColorWithHexString(@"BABDC6")

#pragma mark - private methods

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

NS_INLINE UIColor * _THKColorWithHexString(NSString *hexStr) {
    return [UIColor colorWithHexString:hexStr];
}

#endif /* THKColorsDefine_h */
