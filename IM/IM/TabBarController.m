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
    [self addChildViewController:conversationListViewController title:@"会话列表" imageName:[UIImage systemImageNamed:@"square.and.arrow.up"] selectedImaga:[UIImage systemImageNamed:@"pencil.circle"]];
    
}
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(UIImage *)image selectedImaga:(UIImage *)selectedImage{
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = selectedImage;
    childVC.title = title;
    UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}
@end
