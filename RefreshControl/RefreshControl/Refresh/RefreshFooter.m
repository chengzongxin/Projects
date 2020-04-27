//
//  RefreshFooter.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshFooter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface RefreshFooter ()
@property (strong, nonatomic) UILabel *label;                            //提示标题
@property (strong, nonatomic) UILabel *timeLabel;                        //刷新时间
@property (strong, nonatomic) UIImageView *imageView;                    //下拉箭头
@property (strong, nonatomic) UIActivityIndicatorView *activityView;     //刷新时的活动指示器
@end

@implementation RefreshFooter


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.surplusCount = 10;
    }
    return self;
}

- (void)setupSubviews{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.bounds.size.width, 20)];
    
    _label.backgroundColor = [UIColor clearColor];
    
    _label.textAlignment =NSTextAlignmentCenter;
    
    _label.font = [UIFont systemFontOfSize:16];
    
    _label.textColor = [UIColor blackColor];
    
    _label.text = K_HEAD_NORMAL_TITLE;
    
    [self addSubview:_label];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.bounds.size.width, 20)];
    
    _timeLabel.backgroundColor = [UIColor clearColor];
    
    _timeLabel.textAlignment =NSTextAlignmentCenter;
    
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    _timeLabel.textColor = [UIColor grayColor];
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastRefreshTime"];
    
    _timeLabel.text = time.length >0 ? [NSString stringWithFormat:@"最后刷新 : %@",time] : @"最近未刷新";
    
    [self addSubview:_timeLabel];
    
    CGSize size = [K_HEAD_NORMAL_TITLE boundingRectWithSize:CGSizeMake(1000,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    
    CGFloat oriX = self.bounds.size.width /2 - size.width /2 - 20 *1.2;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(oriX,_label.frame.origin.y -2.5, 20 *1.2,20 *1.2)];
    
    _imageView.image = [UIImage imageNamed:@"arrowdown"];
    
    _imageView.contentMode =UIViewContentModeScaleAspectFit;
    
    [self addSubview:_imageView];
}

//-----------------------更新头部刷新状态-------------------------
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    
    [self preLoading];
//    RefreshStatus   newHeaderState;
//    //获取父视图偏移量
//    CGFloat offY = self.superScrollView.contentOffset.y;
//    if (self.status == RefreshStatusRefreshing) {
//        newHeaderState = RefreshStatusRefreshing;
//    }else{
//
//        if (offY + self.superScrollView.adjustedContentInset.top > K_FOOTER_MAXOFFY) {
//            //到达临界值时
//            if (self.superScrollView.isDragging) {
//                //手指未松开，保持预备刷新状态
//                newHeaderState = RefreshStatusPrepareRefresh;
//            }else{
//                //手指松开，立即进入开始刷新状态
//                newHeaderState = RefreshStatusRefreshing;
//            }
//        }else{
//            //小余临界值，正常状态
//            newHeaderState = RefreshStatusNormal;
//        }
//    }
//
//    //如果头部刷新状态发生了改变就更新
//    if (self.status != newHeaderState)
//    {
//        self.status = newHeaderState;
//    }
}

- (void)preLoading{
    __weak __typeof(self) wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if([wself.superScrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)wself.superScrollView;
            NSInteger lastSection = tableView.numberOfSections - 1;
            if(lastSection >= 0) {
                NSInteger lastRow = [tableView numberOfRowsInSection:tableView.numberOfSections - 1] - 1;
                if(lastRow >= 0) {
                    if(tableView.visibleCells.count > 0) {
                        NSIndexPath *indexPath = [tableView indexPathForCell:tableView.visibleCells.lastObject];
                        if(indexPath.section == lastSection && indexPath.row >= (lastRow - wself.surplusCount)) {
                            if(wself.status == RefreshStatusNormal || wself.status == RefreshStatusFinish)  {
                                if(wself.refreshingBlock) {
                                    [wself startRefresh];
//                                    wself.refreshingBlock();
                                    NSLog(@"%s",__FUNCTION__);
                                }
                            }
                        }
                        if(indexPath.section == lastSection && indexPath.row == lastRow) {
                            self.frame = CGRectMake(0, CGRectGetMaxY(tableView.visibleCells.lastObject.frame), self.bounds.size.width, K_FOOTER_HEIGHT);
                        }
                    }
                }
            }
        }
        if([wself.superScrollView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)wself.superScrollView;
            NSInteger lastSection = collectionView.numberOfSections - 1;
            if(lastSection >= 0) {
                NSInteger lastRow = [collectionView numberOfItemsInSection:collectionView.numberOfSections - 1] - 1;
                if(lastRow >= 0) {
                    if(collectionView.indexPathsForVisibleItems.count > 0) {
                        NSArray *indexPaths = [collectionView indexPathsForVisibleItems];
                        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:YES];
                        NSArray *orderedIndexPaths = [indexPaths sortedArrayUsingDescriptors:@[sort]];
                        NSIndexPath *indexPath = orderedIndexPaths.lastObject;
                        if(indexPath.section == lastSection && indexPath.row >= (lastRow - wself.surplusCount)) {
                            if(wself.status == RefreshStatusNormal || wself.status == RefreshStatusFinish)  {
                                if(wself.refreshingBlock) {
                                    [wself startRefresh];
//                                    wself.refreshingBlock();
                                    NSLog(@"%s",__FUNCTION__);
                                }
                            }
                        }
                        if(indexPath.section == lastSection && indexPath.row == lastRow) {
                            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
                            self.frame = CGRectMake(0, CGRectGetMaxY(cell.frame), self.bounds.size.width, K_FOOTER_HEIGHT);
                        }
                    }
                }
            }
        }
    });
}

// contentsize 改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
    self.transform = CGAffineTransformMakeTranslation(0, self.superScrollView.contentSize.height);
}


- (void)setStatus:(RefreshStatus)status{
    [super setStatus:status];
    
    
    switch (status) {
        case RefreshStatusNormal:
        {
            //正常状态
            _label.text = K_HEAD_NORMAL_TITLE;
            
            [_activityView stopAnimating];
            _imageView.hidden =NO;
            
            //旋转箭头图标为正常
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case RefreshStatusPrepareRefresh:
        {
            //准备刷新状态
            _label.text =K_HEAD_PREPARE_TITLE;
            
            [_activityView stopAnimating];
            _imageView.hidden =NO;
            
            //旋转箭头图标朝上
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case RefreshStatusRefreshing:
        {
            
            //开始刷新状态
            _label.text = K_HEAD_START_TITLE;
            _imageView.hidden = YES;
            
            //向之前绑定的对象传递开始刷新消息
            //            objc_msgSend(self.target, self.selector);
            if (self.refreshingBlock) {
                self.refreshingBlock();
            }else{
                int (*action)(id,SEL,int) = (int(*)(id,SEL,int)) objc_msgSend;
                action(self.target,self.selector,0);
            }
            
            //保存刷新的时间
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
            //用[NSDate date]可以获取系统当前时间
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            _timeLabel.text = [NSString stringWithFormat:@"最后刷新 : %@",currentDateStr];
            
            [[NSUserDefaults standardUserDefaults] setObject:currentDateStr forKey:@"LastRefreshTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //当头部开始刷新时，为头部增加一部分高度，不过此时要先获取底部是否有增加的高度（因为此时尾部可能也在刷新）
            //            UIEdgeInsets  insert = self.superScrollView.contentInset;
            
            
            
            if (!_activityView)
            {
                //添加活动指示器
                _activityView = [[UIActivityIndicatorView alloc] initWithFrame:_imageView.frame];
                _activityView.activityIndicatorViewStyle =UIActivityIndicatorViewStyleGray;
                _activityView.hidesWhenStopped =YES;
                [self addSubview:_activityView];
                
            }
            
            [_activityView startAnimating];
        }
            break;
        case RefreshStatusFinish:
        {
            
        }
            break;
        case RefreshStatusLoadAll:
        {
            _label.text = @"- 已经到底了 -";
            UIEdgeInsets inset = self.orginScrollViewContentInset;
            inset.bottom += K_FOOTER_HEIGHT;
            self.superScrollView.contentInset = inset;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Public Method
//开始刷新
-(void)startRefresh
{
//    [self.superScrollView setContentOffset:CGPointMake(0, -K_HEADER_MAXOFFY) animated:YES];
//    UIEdgeInsets inset = self.superScrollView.contentInset;
//    inset.bottom += K_FOOTER_HEIGHT;
//    [self.superScrollView setContentInset:inset];
    [self.superScrollView setContentInset:UIEdgeInsetsMake(0 ,0, 0,0)];
    self.status = RefreshStatusRefreshing;
}


//结束刷新
-(void)stopRefresh
{
    //此时要记录上拉加载时底部是否有增加的高度
//    [UIView animateWithDuration:0.3 animations:^{
//        UIEdgeInsets inset = self.superScrollView.contentInset;
//        inset.bottom -= K_FOOTER_HEIGHT;
//        [self.superScrollView setContentInset:inset];
//    }];
    [UIView animateWithDuration:0.2 animations:^{
        
        //                [self.superScrollView setContentInset:UIEdgeInsetsMake(K_HEADER_MAXOFFY + self.superScrollView.adjustedContentInset.top + insert.top ,0, 0,0)];
        [self.superScrollView setContentInset:UIEdgeInsetsMake(0 ,0, K_FOOTER_HEIGHT,0)];
        
    }];
    self.status = RefreshStatusNormal;
    
}

- (void)noticeNoMoreData{
    self.status = RefreshStatusLoadAll;
}

- (void)resetNoMoreData{
    self.status = RefreshStatusNormal;
}

@end
