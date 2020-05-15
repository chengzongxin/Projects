//
//  RefreshHeader.m
//  ObjcProjects
//
//  Created by Joe on 2019/4/29.
//  Copyright © 2019 Joe. All rights reserved.
//

#import "RefreshHeader.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface RefreshHeader ()
@property (strong, nonatomic) UILabel *label;                            //提示标题
@property (strong, nonatomic) UILabel *timeLabel;                        //刷新时间
@property (strong, nonatomic) UIImageView *imageView;                    //下拉箭头
@property (strong, nonatomic) UIActivityIndicatorView *activityView;     //刷新时的活动指示器
@end

@implementation RefreshHeader

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
    self.frame = CGRectMake(0, -K_HEADER_HEIGHT-self.orginScrollViewContentInset.top, self.superScrollView.bounds.size.width, K_HEADER_HEIGHT);
    self.label.frame = CGRectMake(0, 80, self.bounds.size.width, 20);
    self.timeLabel.frame = CGRectMake(0, 100, self.bounds.size.width, 20);
    CGSize size = [K_HEAD_NORMAL_TITLE boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    
    CGFloat oriX = self.bounds.size.width /2 - size.width /2 - 20 *1.2;
    self.imageView.frame = CGRectMake(oriX,_label.frame.origin.y -2.5, 20 *1.2,20 *1.2);
}

//-----------------------更新头部刷新状态-------------------------
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    //获取父视图偏移量
    CGFloat offY = self.superScrollView.contentOffset.y;
    //定义新的头，尾刷新状态（待会要判断状态是否发生改变，没改变就不用更新了，为什么要这样呢，后面会知道）
    RefreshStatus   newHeaderState;
    self.superScrollViewContentOffY = offY;  //此处用set方法设置contentOffY,方便子类调用set方法，做其他处理
    if (self.status == RefreshStatusRefreshing) {
        newHeaderState = RefreshStatusRefreshing;
    }else{
        if (offY <= - K_HEADER_MAXOFFY - self.superScrollView.adjustedContentInset.top) {
            //到达临界值时
            if (self.superScrollView.isDragging) {
                //手指未松开，保持预备刷新状态
                newHeaderState = RefreshStatusPrepareRefresh;
            }else{
                //手指松开，立即进入开始刷新状态
                newHeaderState = RefreshStatusRefreshing;
            }
        }else{
            //小余临界值，正常状态
            newHeaderState = RefreshStatusNormal;
        }
    }
    
    //如果头部刷新状态发生了改变就更新
    if (self.status != newHeaderState)
    {
        self.status = newHeaderState;
    }
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
            
            [UIView animateWithDuration:0.2 animations:^{
                [self.superScrollView setContentInset:UIEdgeInsetsMake(K_HEADER_MAXOFFY + self.orginScrollViewContentInset.top,0, self.orginScrollViewContentInset.bottom,0)];
            }];
            
            if (!_activityView)
            {
                //添加活动指示器
                _activityView = [[UIActivityIndicatorView alloc] initWithFrame:_imageView.frame];
                _activityView.activityIndicatorViewStyle =UIActivityIndicatorViewStyleGray;
                _activityView.hidesWhenStopped =YES;
                [self addSubview:_activityView];
                
            }
            
            [_activityView startAnimating];
            
            //向之前绑定的对象传递开始刷新消息
            [self executeRefreshingCallback];
        }
            break;
        case RefreshStatusFinish:
        {
            
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
    [self.superScrollView setContentOffset:CGPointMake(0, -K_HEADER_MAXOFFY-self.orginScrollViewContentInset.top) animated:YES];
    
    self.status = RefreshStatusRefreshing;
}


//结束刷新
-(void)stopRefresh
{
    //此时要记录上拉加载时底部是否有增加的高度
    
    UIEdgeInsets inset = self.orginScrollViewContentInset;
    
    [UIView animateWithDuration:0.3 animations:^{
//        [self.superScrollView setContentInset:UIEdgeInsetsMake(inset.top - self.superScrollView.adjustedContentInset.top,0, inset.bottom,0)];
        [self.superScrollView setContentInset:inset];
    }];
    
    self.status = RefreshStatusNormal;
    
}

@end
