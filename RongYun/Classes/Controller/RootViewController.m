//
//  RootViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "RootViewController.h"
#import "YQNavigationViewController.h"
#import "ConversationListViewController.h"
#import "FriendesListViewController.h"
#import "SettingsViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setControlleres];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setControlleres{
    [self addChildViewController:[[ConversationListViewController alloc] init] title:@"会话" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self addChildViewController:[[FriendesListViewController alloc] init] title:@"好友" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:[[SettingsViewController alloc] init] title:@"设置" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}
-(void)addChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    YQNavigationViewController *nav = [[YQNavigationViewController alloc] initWithRootViewController:vc];
    vc.title =  title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:nav];
}
@end
