//
//  PageViewController.h
//  PageViewControllerDemo
//
//  Created by Joe on 2020/1/6.
//  Copyright © 2020 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageViewController : UIViewController
/** 子类必须实现 */
- (void)setupAllChildViewController;

@end

NS_ASSUME_NONNULL_END
