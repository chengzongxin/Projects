//
//  THKPageBGScrollView.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/10.
//

#import "THKPageBGScrollView.h"

@interface THKPageBGScrollView () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    BOOL _lock;
    BOOL _isObserving;
    BOOL _isScrollingToTop;
    BOOL _shouldScrollHeader;
    BOOL _shouldScrollThisTime;
    __weak UIScrollView *_currentScrollView;
}

@property (nonatomic, strong) NSMutableArray<UIScrollView *> *observedViews;


@end

@implementation THKPageBGScrollView


static void * const kTDCScrollViewKVOContext = (void*)&kTDCScrollViewKVOContext;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.directionalLockEnabled = YES;
        self.bounces = YES;

        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:kTDCScrollViewKVOContext];
        _isObserving = YES;
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:kTDCScrollViewKVOContext];
    [self removeObservedViews];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    CGPoint point = [gestureRecognizer velocityInView:self];
    if (fabs(point.x) > fabs(point.y)) {
        _shouldScrollThisTime = NO;
        return NO;
    }
    
    _shouldScrollHeader = [gestureRecognizer locationInView:self].y < 0;
    //if (_lock && point.y > 0 && !_shouldScrollHeader) {
    if (_lock && point.y > 0) {
        _shouldScrollThisTime = NO;
        return NO;
    }
    
    _shouldScrollThisTime = YES;
    return YES;
}

- (void) addObservedView:(UIScrollView *)scrollView
{
    if (![self.observedViews containsObject:scrollView]) {
        [self.observedViews addObject:scrollView];
        [self addObserverToView:scrollView];
    }
}

- (void) removeObservedViews
{
    for (UIScrollView *scrollView in self.observedViews) {
        [self removeObserverFromView:scrollView];
    }
    [self.observedViews removeAllObjects];
}

- (void) addObserverToView:(UIScrollView *)scrollView
{
    [scrollView addObserver:self
                 forKeyPath:NSStringFromSelector(@selector(contentOffset))
                    options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                    context:kTDCScrollViewKVOContext];

    _lock = (scrollView.contentOffset.y >= -scrollView.contentInset.top);
    //NSLog(@"addObserverToView scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
}

- (void) removeObserverFromView:(UIScrollView *)scrollView
{
    @try {
        [scrollView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(contentOffset))
                           context:kTDCScrollViewKVOContext];
    }
    @catch (NSException *exception) {}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kTDCScrollViewKVOContext && [keyPath isEqualToString:NSStringFromSelector(@selector(contentOffset))]) {
        if (_isScrollingToTop) {
            return;
        }
        CGPoint new = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGPoint old = [[change objectForKey:NSKeyValueChangeOldKey] CGPointValue];
        CGFloat diff = old.y - new.y;

        if (diff == 0.0 || !_isObserving) { return; }
        // 当前不是scrollView，需要滑动
        if (_currentScrollView.tag == 888 && diff) {
            [self scrollView:self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - diff)];
            return;
        }
        if (object == self) {
            if (diff > 0 && _lock && !_shouldScrollHeader) {
                [self scrollView:self setContentOffset:old];
            } else if (((self.contentOffset.y < -self.contentInset.top) && !self.bounces)) {
                [self scrollView:self setContentOffset:CGPointMake(self.contentOffset.x, -self.contentInset.top)];
            }
        } else {
            UIScrollView *scrollView = object;
            _lock = (scrollView.contentOffset.y > -scrollView.contentInset.top) && (self.contentOffset.y >= -_lockArea);
            //NSLog(@"observeValueForKeyPath scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
            if (self.contentOffset.y < -_lockArea && _lock && diff < 0) {
                [self scrollView:scrollView setContentOffset:old];
            }
            // 此次禁止滑动，但是子scrollView已经滑到顶部时，需要滑动bgScrollView
            if (_shouldScrollThisTime == NO && _lock == NO && diff) {
                [self scrollView:self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - diff)];
            }

            if (!_lock && ((self.contentOffset.y > -self.contentInset.top) || self.bounces)) {
                [self scrollView:scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top)];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) scrollView:(UIScrollView*)scrollView setContentOffset:(CGPoint)offset {
    _isObserving = NO;
    scrollView.contentOffset = offset;
    _isObserving = YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    UIScrollView *scrollView = (UIScrollView *)otherGestureRecognizer.view;

    BOOL shouldScroll = scrollView != self && [scrollView isKindOfClass:[UIScrollView class]];

    if (shouldScroll) {
        [self addObservedView:scrollView];
        _currentScrollView = scrollView;
    }

    return shouldScroll;
}

- (NSMutableArray *)observedViews {
    if (!_observedViews) {
        _observedViews = [NSMutableArray array];
    }
    return _observedViews;
}

- (void)scrollToTop:(BOOL)animated
{
    _lock = NO;
    [self setContentOffset:CGPointMake(0, -self.contentInset.top) animated:animated];
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.contentOffset.y > -_lockArea) {
        [self scrollView:self setContentOffset:CGPointMake(self.contentOffset.x, -_lockArea)];
    }
    if ([self.t_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.t_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.t_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.t_delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.t_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.t_delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_currentScrollView) {
        _lock = (_currentScrollView.contentOffset.y > -_currentScrollView.contentInset.top);
        //NSLog(@"scrollViewDidEndDecelerating _currentScrollView.contentOffset.y=%f",_currentScrollView.contentOffset.y);
    } else {
        _lock = NO;
    }
    [self removeObservedViews];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.t_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.t_delegate scrollViewDidScrollToTop:scrollView];
    }
    _isScrollingToTop = NO;
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if ([self.t_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        BOOL res = [self.t_delegate scrollViewShouldScrollToTop:scrollView];
        if (res) {
            _isScrollingToTop = YES;
            _lock = (_currentScrollView.contentOffset.y > -_currentScrollView.contentInset.top);
        }
        return res;
    }
    _isScrollingToTop = YES;
    return YES;
}

- (BOOL)currentViewNotScroll{
    UIScrollView *contentScrollView = self.observedViews.lastObject ;
    if ([contentScrollView isMemberOfClass:UIScrollView.class]) {
//        NSInteger i = contentScrollView.contentOffset.x / contentScrollView.bounds.size.width;
        UIView *visibleView = nil;
        for (UIView *view in contentScrollView.subviews) {
            if (fabs(view.frame.origin.x - contentScrollView.contentOffset.x) < 50) {
                visibleView = view;
            }
        }
        
        if (visibleView.tag == 777) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

@end
