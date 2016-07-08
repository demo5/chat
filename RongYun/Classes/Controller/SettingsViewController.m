//
//  SettingsViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "SettingsViewController.h"
#import "TestViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
    TestViewController *vc = [[TestViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
}

@end
