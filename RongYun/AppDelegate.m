//
//  AppDelegate.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import "RootViewController.h"
#import "LoginViewController.h"

#import "NSString+Extension.h"

#define AppKey  @"cpj2xarljlvpn"
#define RCSecret  @"CztCQW6KwJ6wB"
#define BmobAppKey @"19c91ccb092f8979af4891d58268a070"
@interface AppDelegate ()<RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //bmob
    [Bmob registerWithAppKey:BmobAppKey];
    
    
    [[RCIM sharedRCIM] initWithAppKey:AppKey];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *root = [[LoginViewController alloc] init];
    self.window.rootViewController = root;
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{

        RCUserInfo *info = [[RCUserInfo alloc] init];
        info.userId = userId;
        info.name = userId;
        info.portraitUri=@"http://c.hiphotos.baidu.com/image/h%3D200/sign=43c5dc24ce5c10383b7ec9c28210931c/e1fe9925bc315c609e3db7d185b1cb1349547760.jpg";
        
        return completion(info);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
