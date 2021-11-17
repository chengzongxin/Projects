//
//  ViewController.m
//  reloaddatademo
//
//  Created by Joe.cheng on 2021/3/23.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:UICollectionViewFlowLayout.new];
    _collectionView.backgroundColor = UIColor.whiteColor;
    [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
    
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _datas = @[@1];
        NSLog(@"1s later");
        // method 1
//        _collectionView.dataSource = nil;
//        _collectionView.dataSource = self;
        
//        CGRect frame = self.view.bounds;
//        frame.size.height -= 100;
//        _collectionView.frame = frame;
        
    });
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _datas.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    if (cell.contentView.subviews.count) {
        
        [cell.contentView.subviews performSelector:@selector(removeFromSuperview)];
    }
    
    [cell.contentView addSubview:UISwitch.new];
    
    return cell;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch");
}

@end
