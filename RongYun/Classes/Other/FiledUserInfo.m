//
//  FiledUserInfo.m
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "FiledUserInfo.h"

@implementation FiledUserInfo

/**
 *  归档数据 正在登陆用户的信息以及好友信息
 */
-(void)fileUserInfoAndFriends{
    NSMutableDictionary *userFriendsDic = [NSMutableDictionary dictionary];
    BmobUser *currentUser = [BmobUser getCurrentUser];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
    //查找_Usr表里面id的数据
    [bquery getObjectInBackgroundWithId:currentUser.objectId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //用户信息字典
                NSArray *friends = [object objectForKey:@"friendsId"];
                NSMutableDictionary *userDic = [NSMutableDictionary
                                                dictionaryWithObjectsAndKeys:
                                                [object objectForKey:@"objectId"],@"objectId",
                                                [object objectForKey:@"nickname"],@"nickname",
                                                [object objectForKey:@"token"],@"token",
                                                [object objectForKey:@"friendsId"],@"friendsId",
                                                [object objectForKey:@"portraitUri"],@"portraitUri",
                                                nil];
                NSLog(@"这是我的好友：---%@",friends);
                //得到好友列表
                for (int i = 0;i<friends.count; i++ ) {
                    //查找_Usr表里面id的数据
                    [bquery getObjectInBackgroundWithId:friends[i] block:^(BmobObject *object,NSError *error){
                        if (error){
                            //进行错误处理
                            NSLog(@"好友获取失败");
                        }else{
                            //表里有id为0c6db13c的数据
                            NSLog(@"好友获取成功");
                            if (object) {
                                //得到好友Id
                                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     [object objectForKey:@"objectId"],@"objectId",
                                                     [object objectForKey:@"nickname"],@"nickname",
                                                     [object objectForKey:@"portraitUri"],@"portraitUri",
                                                     nil];
                                NSLog(@"单个好友的信息--------:%@",dic);
                                [userFriendsDic setValue:dic forKey:[NSString stringWithFormat:@"item %d",i]];
                                
                                
                                //归档------------------------------
                                NSLog(@"总的好友的信息--------:%@",userFriendsDic);
                                NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"user_%@.plist", currentUser.objectId]];
                                
                                
                                NSLog(@"路径：-------%@",path);
                                NSMutableDictionary *dictionnary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                    userDic,@"userDic",
                                                                    userFriendsDic,@"userFriendsDic",
                                                                    nil];
                                
                                
                                [dictionnary writeToFile:path atomically:YES];
                                
                            }
                        }
                    }];
                    
                }//好友for循环结束
            }
        }
    }];
}
@end
