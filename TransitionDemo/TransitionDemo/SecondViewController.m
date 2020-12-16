//
//  SecondViewController.m
//  TransitionDemo
//
//  Created by Joe.cheng on 2020/12/16.
//

#import "SecondViewController.h"
#import "PopTransition.h"
@interface SecondViewController () <UINavigationControllerDelegate>
 
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width)];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_avatarImageView];
    // 1、在 SecondViewController 的 viewDidLoad() 方法中，加入滑动手势。
    // 加入左侧边界手势
//    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
//    edgePan.edges = UIRectEdgeLeft;
//    [self.view addGestureRecognizer:edgePan];
    
    UIPanGestureRecognizer * edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
//    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
}

// 2、遵循UINavigationControllerDelegate协议，因为navigationController的动画需要在这里执行，所以需要设置代理为自己
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
// 3、在手势监听方法中，创建 UIPercentDrivenInteractiveTransition 属性，并实现手势百分比更新。
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    // 进度值，这是左侧边界的算法，如果要改为右侧边界，改为self.view.bounds.size.width / [edgePan translationInView:self.view].x;
    CGFloat progress = [edgePan translationInView:self.view].y / self.view.bounds.size.width;
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];

    }else if(edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if(edgePan.state == UIGestureRecognizerStateCancelled || edgePan.state == UIGestureRecognizerStateEnded){
        if(progress > 0.5){
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

// 4、实现返回 UIViewControllerInteractiveTransitioning 的方法并返回刚刚创建的 UIPercentDrivenInteractiveTransition属性。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if([animationController isKindOfClass:[PopTransition class]]){
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}

// 5、还需要设置一下返回动画，否则手势驱动不会生效
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop){
        return [[PopTransition alloc] init]; // 返回pop动画的类
    }else{
        return nil;
    }
}

@end
