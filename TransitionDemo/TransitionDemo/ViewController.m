//
//  ViewController.m
//  TransitionDemo
//
//  Created by Joe.cheng on 2020/12/16.
//

#import "ViewController.h"
#import "PushTransition.h"
#import "SecondViewController.h"
#import "PopTransition.h"

@interface ViewController ()<UINavigationControllerDelegate>
@end

@implementation ViewController

// 必须在viewDidAppear或者viewWillAppear中写，因为每次都需要将delegate设为当前界面
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
    _sourceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    _sourceImageView.image = [UIImage imageNamed:@"timg-2"];
    [self.view addSubview:_sourceImageView];
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush){  // 就是在这里判断是哪种动画类型
        return [[PushTransition alloc] init]; // 返回push动画的类
    }else if (operation == UINavigationControllerOperationPop){  // 就是在这里判断是哪种动画类型
        return [[PopTransition alloc] init]; // 返回pop动画的类{
    }else{
        return nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:SecondViewController.new animated:YES];
}

@end
