//
//  TabBarController.m
//  IM
//
//  Created by Joe.cheng on 2021/7/1.
//

#import "TabBarController.h"
#import "CustomConversationListViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

// 渲染VC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomConversationListViewController *conversationListViewController = [[CustomConversationListViewController alloc] initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP),@(ConversationType_SYSTEM)] collectionConversationType:@[@(ConversationType_SYSTEM)]];
    
    UIImage *norImage = [UIImage tmui_imageWithShape:TMUIImageShapeDetailButtonImage size:CGSizeMake(50, 50) tintColor:UIColor.tmui_randomColor];
    UIImage *selImage = [UIImage tmui_imageWithShape:TMUIImageShapeDetailButtonImage size:CGSizeMake(50, 50) tintColor:UIColor.tmui_randomColor];
    
    [self addChildViewController:conversationListViewController title:@"会话列表" imageName:norImage selectedImaga:selImage];
    
}
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(UIImage *)image selectedImaga:(UIImage *)selectedImage{
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = selectedImage;
    childVC.title = title;
    UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}
@end
