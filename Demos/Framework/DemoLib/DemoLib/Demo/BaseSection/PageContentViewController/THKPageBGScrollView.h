//
//  THKPageBGScrollView.h
//  Demo
//
//  Created by Joe.cheng on 2020/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THKPageBGScrollView : UIScrollView
@property (nonatomic, weak) id<UIScrollViewDelegate> t_delegate;

@property (nonatomic, assign) CGFloat lockArea;

- (void)scrollToTop:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
