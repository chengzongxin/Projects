//
//  RefreshFooter.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshFooter.h"

@interface RefreshFooter ()
@property (strong, nonatomic) UILabel *label;                            //提示标题
@property (strong, nonatomic) UILabel *timeLabel;                        //刷新时间
@property (strong, nonatomic) UIImageView *imageView;                    //下拉箭头
@property (strong, nonatomic) UIActivityIndicatorView *activityView;     //刷新时的活动指示器
@end

@implementation RefreshFooter

- (void)prepare{
    _label = [[UILabel alloc] init];
    
    _label.backgroundColor = [UIColor clearColor];
    
    _label.textAlignment =NSTextAlignmentCenter;
    
    _label.font = [UIFont systemFontOfSize:16];
    
    _label.textColor = [UIColor blackColor];
    
    _label.text = K_HEAD_NORMAL_TITLE;
    
    [self addSubview:_label];
    
    _timeLabel = [[UILabel alloc] init];
    
    _timeLabel.backgroundColor = [UIColor clearColor];
    
    _timeLabel.textAlignment =NSTextAlignmentCenter;
    
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    _timeLabel.textColor = [UIColor grayColor];
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastRefreshTime"];
    
    _timeLabel.text = time.length >0 ? [NSString stringWithFormat:@"最后刷新 : %@",time] : @"最近未刷新";
    
    [self addSubview:_timeLabel];
    
    _imageView = [[UIImageView alloc] init];
    
    _imageView.image = [UIImage imageNamed:@"arrowdown"];
    
    _imageView.contentMode =UIViewContentModeScaleAspectFit;
    
    [self addSubview:_imageView];
}

- (void)placeSubviews{
    self.frame = CGRectMake(0, self.superScrollView.bounds.size.height, self.superScrollView.bounds.size.width, K_FOOTER_HEIGHT);
    self.label.frame = CGRectMake(0, 40, self.bounds.size.width, 20);
    self.timeLabel.frame = CGRectMake(0, 60, self.bounds.size.width, 20);
    CGSize size = [K_HEAD_NORMAL_TITLE boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    
    CGFloat oriX = self.bounds.size.width /2 - size.width /2 - 20 *1.2;
    self.imageView.frame = CGRectMake(oriX,_label.frame.origin.y -2.5, 20 *1.2,20 *1.2);
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
            _imageView.hidden = NO;
            _timeLabel.hidden = NO;
            
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
            _imageView.hidden = NO;
            _timeLabel.hidden = NO;
            
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
            _timeLabel.hidden = NO;
            
            [self executeRefreshingCallback];
            
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
                _activityView.hidesWhenStopped = YES;
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
            _timeLabel.hidden = YES;
            _imageView.hidden = YES;
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Public Method
//开始刷新
-(void)startRefresh{
    [self setFooterInset];
    
    self.status = RefreshStatusRefreshing;
}

//结束刷新
-(void)stopRefresh{
    self.status = RefreshStatusNormal;
}

// Footer 在scrollview的inset下部分多加一部分出来作为显示区域
- (void)setFooterInset{
    UIEdgeInsets inset = self.orginScrollViewContentInset;
    inset.bottom += K_FOOTER_HEIGHT;
    [self.superScrollView setContentInset:inset];
}

- (void)noticeNoMoreData{
    self.status = RefreshStatusLoadAll;
}

- (void)resetNoMoreData{
    self.status = RefreshStatusNormal;
}

@end
