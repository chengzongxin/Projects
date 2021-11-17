//
//  TMSearchBar.h
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/6.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UITextField TMSearchBarTextField;

@protocol TMSearchBarDelegate;

/**
 默认整体背景色为白色
 */
@interface TMSearchBar : UIView

/** 背景图视图,默认image为nil */
@property (nonatomic, strong, readonly)UIImageView *backgroundImageView;

/** 文本输入框视图 | 默认背景色为 RGB(235, 235, 236)
 @warning 外部不要修改textfield的leftView和rightView及其相关其它参数属性，否则可能造成UI显示异常
 */
@property (nonatomic, strong, readonly)TMSearchBarTextField *textField;

/** 输入框及取消按钮整体与四边的案例边距(背景图不受此值影响，尺寸始终铺满) 默认为{top:8, left:12, bottom:8, right:12} */
@property (nonatomic, assign)UIEdgeInsets contentEdgeInsets;

#pragma mark - configs 一些文本内容的UI配置参数
@property (nonatomic, copy, nullable)NSString  *text;///< current/starting search text
@property (nonatomic, strong)UIFont *font;///< 默认为12
@property (nonatomic, strong)UIColor *textColor;///< 默认为blackColor

@property (nonatomic, copy, nullable)NSString  *placeholder;///< default is nil
@property (nonatomic, strong)UIFont *placeholderFont;///< 默认为nil，为nil时与font保持一致
@property (nonatomic, strong)UIColor *placeholderColor;///< 默认为nil,为nil时取70% gray

@property (nonatomic, copy, nullable)NSString  *cancelButtonTitle;///< 默认为 取消
@property (nonatomic, strong)UIFont *cancelButtonFont;///< 默认为12
@property (nonatomic, strong)UIColor *cancelButtonTitleColor;///< 默认为blackColor

@property (nonatomic, strong)UIColor *bottomLineColor;///< 底部线条的颜色，默认为 RGB(228,228,229)
@property (nonatomic, assign, getter=isBottomLineHidden)BOOL bottomLineHide;///< 底部线条是否隐藏，默认为NO，即显示

/** 相关事件回调 */
@property (nonatomic, weak)NSObject<TMSearchBarDelegate> *delegate;


/** 是否为激活状态，当激活状态时右侧会显示取消按钮，取消激活状态后，右侧取消按钮隐藏, 默认状态变化时无动画效果
 @note 此状态需要外部主动调用，通常在用到searchController时会调用，在TMSearchBarDelegate的tmSearchBarTextDidBeginEditing回调中设置YES，在tmSearchBarCancelButtonClicked回调或其它时间设置为NO
 */
@property (nonatomic, assign, getter=isActive)BOOL active;

/** 激活状态变化时可指定UI是否需要过渡动画效果 */
- (void)setActive:(BOOL)active animate:(BOOL)animate;

/// !!!: 若想键盘弹起或收回，可直接调用becomeFirstResponder/resignFirstResponder，也可访问textField间接调用相关方法，效果一样

@end

#pragma mark - 跳转UITextField的一些delegeta事件的自定义协议
@protocol TMSearchBarDelegate

@optional

- (BOOL)tmSearchBarTextShouldBeginEditing:(TMSearchBar *)searchBar;///< 若不实现则默认返回按YES处理
- (void)tmSearchBarTextDidBeginEditing:(TMSearchBar *)searchBar;                     // called when text starts editing
- (void)tmSearchBar:(TMSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (void)tmSearchBarSearchButtonClicked:(TMSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)tmSearchBarCancelButtonClicked:(TMSearchBar *)searchBar;   // called when cancel button pressed

@end

NS_ASSUME_NONNULL_END
