//
//  TMSearchingControllerProtocol.h
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/6.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

#pragma mark - 模糊搜索中vc的协议 | 也可直播继承TMSearchingController

@protocol TMSearchingControllerProtocol <NSObject>

/** 模糊搜索方法
 @param searchText 当前搜索词
 @note 当searchBar里的文本变化时会触发
 @note 子类重写实现
 */
- (void)fuzzySearchForText:(nullable NSString *)searchText;

/** 点击了键盘上的搜索按钮可能会触发的方法
 @param searchText 当前搜索词
 @warning 只有当searchController的tm_searchResultController无值时，此方法才会被触发
 @note 子类重写实现
 */
- (void)clickSearchWithText:(nullable NSString *)searchText;

@end

NS_ASSUME_NONNULL_END
