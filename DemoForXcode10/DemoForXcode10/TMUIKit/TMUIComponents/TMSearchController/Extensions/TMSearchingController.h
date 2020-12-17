//
//  TMSearchingController.h
//  SearchVcTest
//
//  Created by nigel.ning on 2020/8/5.
//  Copyright © 2020 t8t. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMSearchingControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 当searchBar变成firstResponder第一响应者后显示的搜索中视图，通常为关联的模糊搜索列表页
 @note 外部可选择继承此类或用自行实现TMSearchingControllerProtocol协议的其它类
 @note 继承此类也需要自行实现对应的协议方法
 */
@interface TMSearchingController : UIViewController <TMSearchingControllerProtocol>


@end

NS_ASSUME_NONNULL_END
