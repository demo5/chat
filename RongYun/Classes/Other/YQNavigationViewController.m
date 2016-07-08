//
//  YQNavigationViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "YQNavigationViewController.h"

@interface YQNavigationViewController ()

@end

@implementation YQNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
        
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
}


@end
