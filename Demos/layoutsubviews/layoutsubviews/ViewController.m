//
//  ViewController.m
//  layoutsubviews
//
//  Created by Joe.cheng on 2021/2/5.
//

/*
 layoutSubviews方便数据计算，drawRect方便视图重绘。
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发bailayoutSubviews。
 2、addSubview会触发layoutSubviews。
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化。
 4、滚动一个UIScrollView会触发layoutSubviews。
 5、旋转Screen会触发父UIView上的layoutSubviews事件。
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件。 7、直接调用setLayoutSubviews。
 */


#import "ViewController.h"
#import "RedView.h"
#import "YellowView.h"
@interface ViewController ()

@end

@implementation ViewController

static int num = 1;
void aprint(UIViewController *vc){
//    [vc.view layoutIfNeeded];
    NSLog(@"%d",num++);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    RedView *red = [[RedView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    red.backgroundColor = UIColor.redColor;
    aprint(self);
    [self.view addSubview:red];
    aprint(self);
    YellowView *yellow = [[YellowView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    yellow.backgroundColor = UIColor.yellowColor;
    aprint(self);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [red addSubview:yellow];
        
    });
    
    
    
    aprint(self);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        red.frame = CGRectMake(100, 200, 400, 400);
        aprint(self);
    });
}





@end
