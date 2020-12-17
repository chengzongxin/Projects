//
//  THKShowBigImageViewController.m
//  Demo
//
//  Created by Joe.cheng on 2020/12/14.
//

#import "THKShowBigImageViewController.h"
#import "THKShadowImageView.h"
#import "THKAnimatorTransition.h"
#import "UIView+TMUI.h"
#import "THKShadowImageView.h"

@interface THKShowBigImageViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) THKAnimatorTransition *transitionAnimator;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, copy) NSArray *images;

@property (nonatomic, copy) NSArray<NSValue *> *frames;

@property (nonatomic, assign) NSInteger index;


@end

@implementation THKShowBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blackColor;
    
    if (self.images) {
        [self.view addSubview:self.collectionView];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        [self.view addSubview:self.imageView];
        self.imageView.image = self.image;
    }
}

+ (void)showBigImageWithImageView:(UIImageView *)imageView transitionStyle:(THKTransitionStyle)transitionStyle{
    
    UIViewController *fromVC = imageView.tmui_viewController;
    fromVC.modalPresentationStyle = UIModalPresentationCustom;
    THKShowBigImageViewController *imageVC = [[THKShowBigImageViewController alloc] init];
    imageVC.image = imageView.image;
    // transition
    THKAnimatorTransition *animatorTransition = [[THKAnimatorTransition alloc] init];
    // 设置手势
    [animatorTransition addGestureWithVC:imageVC direction:THKTransitionGestureDirectionDown];;
    // 设置动画图片尺寸，图片
    animatorTransition.animateImageView.image = imageView.image;
    animatorTransition.imgFrame = [imageView convertRect:imageView.frame toView:UIApplication.sharedApplication.keyWindow];
    // 设置转场代理
    fromVC.transitioningDelegate = animatorTransition;
    fromVC.navigationController.delegate = animatorTransition;
    imageVC.transitioningDelegate = animatorTransition;
    imageVC.transitionAnimator = animatorTransition; // 强引用，避免被释放
    
    if (transitionStyle == THKTransitionStylePush) {
        [fromVC.navigationController pushViewController:imageVC animated:YES];
    }else{
        [fromVC presentViewController:imageVC animated:YES completion:nil];
    }
}

+ (void)showBigImageWithImageView:(NSArray *)images frames:(NSArray<NSValue *> *)frames index:(NSInteger)index transitionStyle:(THKTransitionStyle)transitionStyle fromVC:(nonnull UIViewController *)fromVC{
    fromVC.modalPresentationStyle = UIModalPresentationCustom;
    THKShowBigImageViewController *imageVC = [[THKShowBigImageViewController alloc] init];
    imageVC.images = images;
    imageVC.frames = frames;
    imageVC.index = index;
    // transition
    THKAnimatorTransition *animatorTransition = [[THKAnimatorTransition alloc] init];
    // 设置手势
    [animatorTransition addGestureWithVC:imageVC direction:THKTransitionGestureDirectionDown];;
    // 设置动画图片尺寸，图片
    animatorTransition.animateImageView.image = images[index];
    animatorTransition.imgFrame = frames[index].CGRectValue;
    // 设置转场代理
    fromVC.transitioningDelegate = animatorTransition;
    fromVC.navigationController.delegate = animatorTransition;
    imageVC.transitioningDelegate = animatorTransition;
    imageVC.transitionAnimator = animatorTransition; // 强引用，避免被释放
    
    if (transitionStyle == THKTransitionStylePush) {
        [fromVC.navigationController pushViewController:imageVC animated:YES];
    }else{
        [fromVC presentViewController:imageVC animated:YES completion:nil];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    
    UIImageView *imgV = (UIImageView *)[cell viewWithTag:888];
    if (!imgV) {
        imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.layer.masksToBounds = YES;
        imgV.tag = 888;
        [cell addSubview:imgV];
    }
    imgV.image = _images[indexPath.item];
    
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.transitionAnimator.animateImageView.image = self.images[index];
    self.transitionAnimator.imgFrame = self.frames[index].CGRectValue;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    }
    return _collectionView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
