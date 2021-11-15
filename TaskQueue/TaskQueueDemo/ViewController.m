//
//  ViewController.m
//  TaskQueueDemo
//
//  Created by Joe.cheng on 2021/4/16.
//

#import "ViewController.h"
#import "TaskManager.h"
#import "Task1.h"
#import "Task2.h"
#import "Task3.h"
#import "Task4.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = @"点击屏幕，执行任务";
    
    _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 88, 100, 100)];
    [self.view addSubview:_imgView1];
    _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(120 + 20, 88, 100, 100)];
    [self.view addSubview:_imgView2];
    _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(220 + 40, 88, 100, 100)];
    [self.view addSubview:_imgView3];
    
    
    
    TaskManager.sharedInstance.taskReady = ^(TaskOperation * _Nonnull op) {
        [self appendStr:[NSString stringWithFormat:@"<Start task:%@>",op.name]];
        [self appendStr:@"准备执行..."];
    };
    
    TaskManager.sharedInstance.taskExecute = ^(TaskOperation * _Nonnull op) {
        [self appendStr:@"正在执行..."];
    };
    
    TaskManager.sharedInstance.taskFinish = ^(TaskOperation * _Nonnull op) {
        [self appendStr:@"完成执行!"];
    };
    
    TaskManager.sharedInstance.taskAllFinish = ^{
        [self appendStr:@"==========  所有任务完成执行  ============"];
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"===============task begin===============");
    
    self.imgView1.image = nil;
    self.imgView2.image = nil;
    self.imgView3.image = nil;
    
    TaskOperation *t1 = [self task1];
    TaskOperation *t2 = [self task2];
    TaskOperation *t3 = [self task3];
    TaskOperation *t4 = [self task4];
    TaskOperation *t5 = [self task5];
    
    [TaskManager.sharedInstance addTask:t1];
    [TaskManager.sharedInstance addTask:t2];
    [TaskManager.sharedInstance addTask:t3];
    [TaskManager.sharedInstance addTask:t4];
    [TaskManager.sharedInstance addTask:t5];
    
    self.label.text = [NSString stringWithFormat:@"点击屏幕执行%zd个任务",TaskManager.sharedInstance.taskCount];
    
    
    [TaskManager.sharedInstance start];
    NSLog(@"===============task end===============");
}

/// 任务1，改变背景色
- (TaskOperation *)task1{
    // 1. 创建任务
    Task1 *task1 = [[Task1 alloc] initWithView:self.view];
    task1.name = @"任务1，改变背景色";
    // 2. 添加任务
    // 3. 完成任务
//    [task1 finish];
    return task1;
}

/// 任务2，添加滑块动画
- (TaskOperation *)task2{
    Task2 *task2 = [[Task2 alloc] initWithVC:self];
    task2.name = @"任务2，添加滑块动画";
    return task2;
}

/// 任务3，弹窗交互
- (TaskOperation *)task3{
    Task3 *task3 = [[Task3 alloc] initWithVC:self];
    task3.finishBlock = ^(id  _Nullable data) {
        if ([data intValue] == 2) {
            [self removeTask:Task4.class];
        }
    };
    task3.name = @"任务3，弹窗交互";
    return task3;
}

/// 任务4，下载图片
- (TaskOperation *)task4{
    Task4 *task4 = [[Task4 alloc] init];
    task4.finishBlock = ^(NSArray *data) {
        self.imgView1.image = data[0];
        self.imgView2.image = data[1];
        self.imgView3.image = data[2];
        NSLog(@"%@",data);
    };
    task4.name = @"任务4，下载图片";
    return task4;
}

/// 任务4，打印输出修改白色背景
- (TaskOperation *)task5{
    TaskOperation *task5 = [[TaskOperation alloc] init];
    __weak __typeof(task5)wt5 = task5;
    task5.executeBlock = ^{
        NSLog(@"task5 exeuting...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"task5 finish");
            self.view.backgroundColor = UIColor.whiteColor;
            [wt5 finish];
        });
    };
    task5.name = @"任务5，打印输出修改白色背景";
    return task5;
}



#pragma mark - Pravite
- (void)appendStr:(NSString *)string{
    [NSOperationQueue.mainQueue addOperationWithBlock:^{
        self.label.text = [NSString stringWithFormat:@"%@\n%@",self.label.text,string];
    }];
}

- (void)removeTask:(Class)cls{
    TaskOperation *task3 = nil;
    for (TaskOperation *task in TaskManager.sharedInstance.tasks) {
        if ([task isKindOfClass:cls]) {
            task3 = task;
        }
    }
    
    [TaskManager.sharedInstance removeTask:task3];
}

@end
