//
//  ViewController.m
//  THKAuthenticationViewDemo
//
//  Created by Joe.cheng on 2021/1/19.
//

#import "ViewController.h"
#import "THKIdentityView.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) THKIdentityView *view1;
@property (nonatomic, strong) THKIdentityView *view2;
@property (nonatomic, strong) THKIdentityView *view3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    THKIdentityView *i1 = [THKIdentityView identityViewWithType:999 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i1];
    
    THKIdentityView *i2 = [THKIdentityView identityViewWithType:10 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i2];
    
    THKIdentityView *i3 = [THKIdentityView identityViewWithType:11 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i3];
    
    THKIdentityView *i4 = [THKIdentityView identityViewWithType:12 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i4];
    
    THKIdentityView *i5 = [THKIdentityView identityViewWithType:13 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i5];
    
    THKIdentityView *i6 = [THKIdentityView identityViewWithType:14 style:THKIdentityViewStyle_Full];
    [self.view addSubview:i6];
    
    NSLog(@"%@",NSStringFromCGSize(i6.viewSize));
    
    [i1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(100);
    }];
    
    [i2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(i1.mas_right).offset(20);
        make.top.mas_equalTo(100);
    }];
    
    [i3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(i2.mas_right).offset(20);
        make.top.mas_equalTo(100);
    }];
    
    [i4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(i3.mas_right).offset(20);
        make.top.mas_equalTo(100);
    }];
    
    [i5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.equalTo(i1.mas_bottom).offset(50);
    }];
    
    [i6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(i5.mas_right).offset(20);
        make.top.equalTo(i1.mas_bottom).offset(50);
    }];
    
    
    THKIdentityView *i7 = [THKIdentityView identityViewWithType:11 style:THKIdentityViewStyle_Icon];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11611657654_.pic"]];
    imgV.layer.cornerRadius = 25;
    //    imgV.layer.masksToBounds = YES;
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.equalTo(i6.mas_bottom).offset(50);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    imgV.userInteractionEnabled = YES;
    [imgV addSubview:i7];
    
    
}

- (void)test{
    
    
//    THKIdentityView *view1 = [[THKIdentityView alloc] initWithType:1 style:THKIdentityViewStyle_Full];
//    view1.iconOffset = CGPointMake(0, 0);
//    [self.view addSubview:view1];
//
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(100);
////        make.size.mas_equalTo(CGSizeMake(50, 50));
//    }];
//
//    THKIdentityView *view2 = [[THKIdentityView alloc] initWithType:2 style:THKIdentityViewStyle_Full];
////    view2.iconOffset = CGPointMake(10, 10);
//    [self.view addSubview:view2];
//
//
//    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(100);
//        make.top.equalTo(view1.mas_bottom).offset(50);
//    }];
//
//    THKIdentityView *view4 = [THKIdentityView identityViewWithType:3 style:THKIdentityViewStyle_Full];
//    [self.view addSubview:view4];
//
//    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view1.mas_right).offset(20);
//        make.top.equalTo(view1);
//    }];
//
//    THKIdentityView *view5 = [THKIdentityView identityViewWithType:4 style:THKIdentityViewStyle_Full];
//    [self.view addSubview:view5];
//
//    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view4.mas_right).offset(20);
//        make.top.equalTo(view4);
//    }];
//
//
//
//    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11611657654_.pic"]];
//    imgV.layer.cornerRadius = 25;
////    imgV.layer.masksToBounds = YES;
//    [self.view addSubview:imgV];
//    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(100);
//        make.top.equalTo(view2.mas_bottom).offset(50);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
//    imgV.userInteractionEnabled = YES;
//    THKIdentityView *view3 = [THKIdentityView identityViewWithType:0 style:THKIdentityViewStyle_Icon];
//    view3.iconOffset = CGPointMake(-10, -10);
//    [imgV addSubview:view3];
//
//
//    view1.tapBlock = ^(NSInteger type) {
//        NSLog(@"tap block");
//    };
//
//    view2.tapBlock = ^(NSInteger type) {
//        NSLog(@"tap block");
//    };
//
//    view3.tapBlock = ^(NSInteger type) {
//        NSLog(@"tap block");
//    };
//
//
//    _view1 = view1;
//    _view2 = view2;
//    _view3 = view3;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (_view1.type == THKAuthenticationType_3) {
//        _view1.type = THKAuthenticationType_0;
//        _view2.type = THKAuthenticationType_0;
//    }else{
//        _view1.type++;
//        _view2.type++;
//    }
    
    _view1.iconOffset = CGPointMake(_view1.iconOffset.x+1, _view1.iconOffset.y+1);
    _view2.iconOffset = CGPointMake(_view2.iconOffset.x+1, _view2.iconOffset.y+1);
    _view3.iconOffset = CGPointMake(_view3.iconOffset.x+1, _view3.iconOffset.y+1);
}


@end
