//
//  ViewController.m
//  sizeThatFits
//
//  Created by Joe.cheng on 2021/3/22.
//

#import "ViewController.h"
#import "SizeTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UISegmentedControl *segmentedTitleView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNavigationItems];
    
    [self handleTableViewStyleChanged:0];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = NSIndexPath.description;
//    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section%@", @(section)];
}

- (UIView *)supertableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView realTitleForHeaderInSection:section];
//    if (title) {
//        TMUITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerViewID"];
//        headerView.parentTableView = tableView;
//        headerView.type = TMUITableViewHeaderFooterViewTypeHeader;
//        headerView.titleLabel.text = title;
//        return headerView;
//    }
    return nil;
}

// 是否有定义某个section的header title
- (NSString *)tableView:(UITableView *)tableView realTitleForHeaderInSection:(NSInteger)section {
    if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString *sectionTitle = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
        if (sectionTitle && sectionTitle.length > 0) {
            return sectionTitle;
        }
    }
    return nil;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    TMUITableViewHeaderFooterView *headerView = (TMUITableViewHeaderFooterView *)[self supertableView:tableView viewForHeaderInSection:section];
//    TMUIButton *button = (TMUIButton *)headerView.accessoryView;
//    if (!button) {
//        button = [self generateLightBorderedButton];
//        [button setTitle:@"Button" forState:UIControlStateNormal];
//        button.titleLabel.font = UIFontMake(14);
//        button.contentEdgeInsets = UIEdgeInsetsMake(4, 12, 4, 12);
//        [button sizeToFit];
////        button.tmui_automaticallyAdjustTouchHighlightedInScrollView = YES;
//        button.tmui_outsideEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
//        [button addTarget:self action:@selector(handleButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
//        headerView.accessoryView = button;
//    }
//    return headerView;
//}

- (void)handleButtonEvent:(UIView *)view {
    // 通过这个方法获取到点击的按钮所处的 sectionHeader，可兼容 sectionHeader 停靠在列表顶部的场景
//    NSInteger sectionIndexForView = [self.tableView tmui_indexForSectionHeaderAtView:view];
//    [TMToast toast:@(sectionIndexForView).stringValue];
//    if (sectionIndexForView != -1) {
//        [QMUITips showWithText:[NSString stringWithFormat:@"点击了 section%@ 上的按钮", @(sectionIndexForView)] inView:self.view hideAfterDelay:1.2];
//    } else {
//        [QMUITips showError:@"无法定位被点击的按钮所处的 section" inView:self.view hideAfterDelay:1.2];
//    }
}


- (void)setupNavigationItems {
////    [super setupNavigationItems];
//    if (!self.segmentedTitleView) {
//        self.segmentedTitleView = [[UISegmentedControl alloc] initWithItems:@[
//            @"Plain",
//            @"Grouped",
//            @"InsetGrouped"
//        ]];
//        [self.segmentedTitleView addTarget:self action:@selector(handleTableViewStyleChanged:) forControlEvents:UIControlEventValueChanged];
//
//        UIColor *tintColor = self.navigationController.navigationBar.tintColor;
//        if (@available(iOS 13.0, *)) {
//            self.segmentedTitleView.selectedSegmentTintColor = tintColor;
//        } else {
//            self.segmentedTitleView.tintColor = tintColor;
//        }
//        [self.segmentedTitleView setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor} forState:UIControlStateNormal];
//        [self.segmentedTitleView setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.tmui_randomColor} forState:UIControlStateSelected];
//    }
//    self.segmentedTitleView.selectedSegmentIndex = self.tableView.tmui_style;
//    self.navigationItem.titleView = self.segmentedTitleView;
}

- (void)handleTableViewStyleChanged:(UISegmentedControl *)segmentedControl {
    [self.tableView removeFromSuperview];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.orangeColor;
//    [self.tableView registerClass:TMUITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerViewID"];
    [self.view addSubview:self.tableView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.dataSource = self;
        NSLog(@"123123");
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableView.dataSource = self;
    NSLog(@"123123");
}

//- (TMUIButton *)generateLightBorderedButton {
//    TMUIButton *button = [[TMUIButton alloc] tmui_initWithSize:CGSizeMake(200, 40)];
//    button.titleLabel.font = UIFontBoldMake(14);
//    button.tintColorAdjustsTitleAndImage = UIColor.tmui_randomColor;
//    button.backgroundColor = [UIColor.tmui_randomColor tmui_transitionToColor:UIColorWhite progress:.9];
//    button.highlightedBackgroundColor = [UIColor.tmui_randomColor tmui_transitionToColor:UIColorWhite progress:.75];// 高亮时的背景色
//    button.layer.borderColor = [button.backgroundColor tmui_transitionToColor:UIColor.tmui_randomColor progress:.5].CGColor;
//    button.layer.borderWidth = 1;
//    button.layer.cornerRadius = 4;
//    button.highlightedBorderColor = [button.backgroundColor tmui_transitionToColor:UIColor.tmui_randomColor progress:.9];// 高亮时的边框颜色
//    return button;
//}

@end
