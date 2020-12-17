//
//  Table1ViewController.m
//  Demo
//
//  Created by Joe.cheng on 2020/11/27.
//

#import "Table1ViewController.h"
#import "THKShowBigImageViewController.h"
@interface Table1ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) NSArray *imgs;
@end

@implementation Table1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 1 ; i < 7; i ++) {
        NSString *imgStr = [NSString stringWithFormat:@"timg-%d",i];
        UIImage *img = [UIImage imageNamed:imgStr];
        [imgs addObject:img];
    }
    _imgs = imgs;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imgs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.width * 3 / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%@",indexPath.row,NSStringFromClass(self.class)];
    
    UIImageView *imgV = (UIImageView *)[cell viewWithTag:888];
    if (!imgV) {
        imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 3 / 4)];
        imgV.layer.masksToBounds = YES;
        imgV.tag = 888;
        [cell addSubview:imgV];
    }
    imgV.image = _imgs[indexPath.row];
    
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray <NSValue *>* frames = [NSMutableArray array];
    for (int i = 0; i < _imgs.count; i++) {
        NSIndexPath *aIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:aIndexPath];
        CGRect frame = [cell convertRect:cell.frame toView:UIApplication.sharedApplication.keyWindow];
        [frames addObject:[NSValue valueWithCGRect:frame]];
    }
    
    [THKShowBigImageViewController showBigImageWithImageView:_imgs frames:frames index:indexPath.row transitionStyle:THKTransitionStylePush fromVC:self];
}


@end
