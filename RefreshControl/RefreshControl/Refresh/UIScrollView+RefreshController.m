//
//  UIScrollView+RefreshController.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "UIScrollView+RefreshController.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "RefreshConstant.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RefreshGifHeader.h"
#import "RefreshGifFooter.h"
@implementation UIScrollView (RefreshController)

- (void)addRefreshWithHeaderBlock:(RefreshingBlock)headerBlock footerBlock:(RefreshingBlock)footerBlock{
    if (headerBlock) {
        RefreshHeader *header = [[RefreshHeader alloc] init];
        header.refreshingBlock = headerBlock;
        self.header = header;
    }
    
    if (footerBlock) {
        RefreshFooter *footer = [[RefreshFooter alloc] init];
        footer.refreshingBlock = footerBlock;
        self.footer = footer;
    }
}

- (void)addRefreshWithTarget:(id)target headerSelector:(SEL)headerSelector footerSelect:(SEL)footerSelect{
    //添加头部刷新
    if (headerSelector) {
        RefreshHeader *header = [[RefreshHeader alloc] init];
        header.target = target;
        header.selector = headerSelector;
        self.header = header;
    }
    //添加尾部刷新
    if (footerSelect) {
        RefreshFooter *footer = [[RefreshFooter alloc] init];
        footer.target = target;
        footer.selector = footerSelect;
        self.footer = footer;
    }
}

- (void)addRefreshWithGifHeaderBlock:(RefreshingBlock)headerBlock gifFooterBlock:(RefreshingBlock)footerBlock{
    if (headerBlock) {
        RefreshGifHeader *header = [[RefreshGifHeader alloc] init];
        header.refreshingBlock = headerBlock;
        self.header = header;
    }
    
    if (footerBlock) {
        RefreshGifFooter *footer = [[RefreshGifFooter alloc] init];
        footer.refreshingBlock = footerBlock;
        self.footer = footer;
    }
}




- (void)headerStartRefresh{
    [self.header startRefresh];
}

- (void)headerStopRefresh{
    [self.header stopRefresh];
}

- (void)footerStartRefresh{
    [self.footer startRefresh];
}

- (void)footerStopRefresh{
    [self.footer stopRefresh];
}

- (void)noticeNoreMoreData{
    [self.footer noticeNoMoreData];
}

- (void)resetNoMoreData{
    [self.footer resetNoMoreData];
}

#pragma mark - Setter & Getter
- (void)setHeader:(RefreshHeader *)header{
    if (header != self.header) {
        // 删除旧的，添加新的
        [self.header removeFromSuperview];
        [self insertSubview:header atIndex:0];
        
        // 存储新的
        objc_setAssociatedObject(self,@selector(header),header,OBJC_ASSOCIATION_RETAIN);
    }
}

- (RefreshHeader *)header{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFooter:(RefreshFooter *)footer{
    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self insertSubview:footer atIndex:0];
        footer.layer.zPosition = -1;
        
        // 存储新的
        objc_setAssociatedObject(self,@selector(footer),footer,OBJC_ASSOCIATION_RETAIN);
    }
}

- (RefreshFooter *)footer{
    return objc_getAssociatedObject(self, _cmd);
}

@end
