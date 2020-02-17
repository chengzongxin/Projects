//
//  HomePageControl.h
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/17.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageControl : UIView

@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1

//@property(nonatomic) BOOL hidesForSinglePage;          // hide the the indicator if there is only one page. default is NO
//
//@property(nonatomic) BOOL defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO
//- (void)updateCurrentPageDisplay;                      // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately
//
//- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;   // returns minimum size required to display dots for given page count. can be used to size control if page count could change

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *pageIndicatorNormalColor;
@end

NS_ASSUME_NONNULL_END
