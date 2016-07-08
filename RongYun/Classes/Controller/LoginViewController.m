//
//  LoginViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/5.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "LoginViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "FiledUserInfo.h"
#import "GetToken.h"
#import "RootViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic,strong) NSString *token;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *注册
 */
- (IBAction)register:(UIButton *)sender {
    //bmob注册
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.username.text];
    [bUser setPassword:self.password.text];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"注册成功------");
            
            //----将token写入本地数据库------
            //获取单例
            NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
            //写入token
            self.token = [GetToken getTokenWithUserId:bUser.objectId userName:self.username.text portraitUri:@""];
            [userdefaults setObject:self.token forKey:[NSString stringWithFormat:@"%@_token",bUser.objectId]];
            //同步数据
            [userdefaults synchronize];
            
            //将token写入bmob服务器-------
            //查找_User表
            BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
            //查找_User表里面id的数据
            [bquery getObjectInBackgroundWithId:bUser.objectId block:^(BmobObject *object,NSError *error){
                //没有返回错误
                if (!error) {
                    //对象存在
                    if (object) {
                        BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                        //设置token
                        [obj1 setObject:self.token forKey:@"token"];
                        //获取nickname
                        
                        [UserInformation sharedInstance].nickname =[obj1 objectForKey:@"nickname"];
                        
                        //异步更新数据
                        [obj1 updateInBackground];
                    }
                }else{
                    //进行错误处理
                }
            }];//写入bmob  end
            
            
        } else {
            NSLog(@"注册失败-------error：--%@",error);
        }
     
    }];
    
}
/**
 *  登录
 */
- (IBAction)login:(UIButton *)sender {
    
    [BmobUser loginWithUsernameInBackground:self.username.text password:self.password.text block:^(BmobUser *user, NSError *error) {
        if (!error) {//只要能够登录成功说明此用户已经注册，则一定有一个token,要么在本地，要么在服务器
            BmobUser *currentUser = [BmobUser getCurrentUser];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userToken = [defaults objectForKey:[NSString stringWithFormat:@"%@_token",currentUser.objectId]];
            
            if (userToken) {//本地有token
                [self loginToRongYunWithToken:userToken];
            }else{//本地没有token
                //查找_User表
                BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
                //查找_Usr表里面id的数据
                [bquery getObjectInBackgroundWithId:currentUser.objectId block:^(BmobObject *object,NSError *error){
                    if (error){
                        //进行错误处理
                    }else{
                        //表里有id为0c6db13c的数据
                        if (object) {
                            //得到token
                            NSString *token = [object objectForKey:@"token"];
                            //将此token写入本地
                            //----将token写入本地数据库------
                            //获取单例
                            NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
                            //写入token
                            self.token = token;
                            [userdefaults setObject:self.token forKey:[NSString stringWithFormat:@"%@_token",currentUser.objectId]];
                            //同步数据
                            [userdefaults synchronize];
                            
                            [self loginToRongYunWithToken:token];
                        }
                    }
                }];
                
            }
            
        }else{
            NSLog(@"BMOB登录失败-----");
        }
    }];
    
    
}
/**
 *  使用token登录到融云服务器
 *
 *  @param token 登录的token
 */
-(void)loginToRongYunWithToken:(NSString *)token{
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
        //返回主线程跳转页面
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            RootViewController *root= [[RootViewController alloc] init];
            [self presentViewController:root animated:YES completion:^{
                
            }];
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            //登陆成功后归档用户信息储存本地
             [[[FiledUserInfo alloc] init] fileUserInfoAndFriends];
        });
        
    } error:^(RCConnectErrorCode status) {
        
        NSLog(@"登陆的错误码为:%ld", (long)status);
        
    } tokenIncorrect:^{//token过期或者不正确。
        
        NSLog(@"token错误");
        
    }];
}


















@end
