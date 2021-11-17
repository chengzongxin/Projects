//
//  ViewController.m
//  labelTest
//
//  Created by Joe.cheng on 2021/2/20.
//

#import "ViewController.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UIButton+ClickRange.h"
#import "UITextField+YYAdd.h"
#import "model.h"
#import "UILabel+colortest.h"

typedef ViewController * (^vcblk)(int,int);
#define str(x,y) [NSString stringWithFormat:@"%d-%d",x,y]

@interface ViewController ()

@property (nonatomic, strong)  vcblk str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewConstraint];
    
//    self.str(1,2);
    
//    self.str(1, 2);
}

- (void)setViewConstraint {
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    // 1. 禁止将 AutoresizingMask 转换为 Constraints
    purpleView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.translatesAutoresizingMaskIntoConstraints = NO;

    // 2. 为防止添加约束过程中程序crash,可以先将子视图添加到父视图中
    [self.view addSubview:purpleView];
    [self.view addSubview:blueView];

    // 3.为purpleView添加 width 约束和 height 约束
   NSLayoutConstraint *purpleViewWidthConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:100];
    NSLayoutConstraint *purpleViewHeightConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:100];
//    purpleViewWidthConstraint.active = YES;
//    purpleViewHeightConstraint.active = YES;
    [NSLayoutConstraint activateConstraints:@[purpleViewWidthConstraint,purpleViewHeightConstraint]];
//    [purpleView addConstraint:purpleViewWidthConstraint];   // 可使用purpleViewWidthConstraint.active = YES;替换
//    [purpleView addConstraint:purpleViewHeightConstraint];  // 可使用purpleViewHeightConstraint.active = YES;替换
//
//    // 4.为blueView添加 width 约束和 height 约束，有两种方式。第一种是可以直接类似第三步为purpleView添加宽高约束那样添加；第二种方法是参考purpleView的宽高约束，等宽等高即可。(***注意:此时添加的约束一共有blueView 和 purpleView 两项,它们属于同一层级，添加约束时需要将约束添加到它们共同的父类上，也就是self上)
//    NSLayoutConstraint *blueViewWidthConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:purpleView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
//    NSLayoutConstraint *blueViewHeightConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:purpleView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
//    [self.view addConstraint:blueViewWidthConstraint];   // 可使用blueViewWidthConstraint.active = YES;替换
//    [self.view addConstraint:blueViewHeightConstraint];  // 可使用blueViewHeightConstraint.active = YES;替换
//
//    // 5.为purpleView添加距离顶部距离为100的顶部约束，并且在x方向上居中(***注意：此时添加的约束一共有purpleView 和 self 两项,self比purpleView层级要高，添加约束时需要将约束添加到层级较高的视图上，也就是self上)
//    NSLayoutConstraint *purpleViewTopConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
//    NSLayoutConstraint *purpleViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:purpleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    [self.view addConstraint:purpleViewTopConstraint];   // 可使用purpleViewTopConstraint.active = YES;替换
//    [self.view addConstraint:purpleViewCenterXConstraint];   // 可使用purpleViewCenterXConstraint.active = YES;替换
//
//    // 6.为buleView添加Y方向上距离purpleView为100的约束，并且blueView在x方向上居中(***注意：根据4、5中括号内注意的描述，可知这两个约束也是要添加到self上的)
//    NSLayoutConstraint *buleViewTopConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:purpleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:100];
//    NSLayoutConstraint *blueViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    [self.view addConstraint:buleViewTopConstraint];     // 可使用buleViewTopConstraint.active = YES;替换
//    [self.view addConstraint:blueViewCenterXConstraint];     //  可使用blueViewCenterXConstraint.active = YES;替换
}

- (void)other{
    
    UIFont *font = [UIFont systemFontOfSize:16];
        
        NSLog(@"font \npointSize=%lf \nascender=%lf \ndescender= %lf \ncapHeight= %lf \nxHeight= %lf \nleading= %lf \nlineHeight = %lf, \na+d=%lf",
              font.pointSize,
              font.ascender,
              font.descender,
              font.capHeight,
              font.xHeight,
              font.leading,
              font.lineHeight,
              font.ascender-font.descender);
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
//    btn.clickEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    tf.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:tf];
    tf1 = tf;

    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 300, 100, 100);
    [btn1 t_setNormalTextColor:UIColor.cyanColor];
    btn1.backgroundColor = [btn1 t_normalTextColor];
    [self.view addSubview:btn1];
    
    [btn1 t_setNormalTextColor:UIColor.systemGray6Color];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(300, 300, 100, 100);
    btn2.backgroundColor = [btn2 t_normalTextColor];
    [self.view addSubview:btn2];
    
    
    for (int i = 0; i < 10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn t_setNormalTextColor:[UIColor colorWithRed:i green:i blue:i alpha:1]];
        NSLog(@"%p.%@",[btn t_normalTextColor],[btn t_normalTextColor]);
    }
    
    NSString *value = nil;
    NSDictionary *dic = @{@"key":value};
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value, @"key", nil];
    NSLog(@"%@",dic);
    
    
    model *m = nil;
    CGSize infiSize = m.size;
    NSLog(@"====%@",NSStringFromCGSize(infiSize));
    NSLog(@"%f,%f",infiSize.width,infiSize.height);
    
    BOOL equal = CGSizeEqualToSize(infiSize, CGSizeZero);
    NSLog(@"%d",equal);
    
    
    UILabel.new.textcolor1(UIColor.redColor);
}

UITextField *tf1;

- (void)click:(UIButton *)btn{
    NSLog(@"click %@",tf1.text);
    
    if (tf1.text.length % 2) {
        
        [tf1 selectAllText];
    }else{
        
        if (tf1.text.length > 4) {
            [tf1 setSelectedRange:NSMakeRange(1, 2)];
        }
        
    }
    
    
    
    
}
@end
