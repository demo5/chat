//
//  UserInformation.h
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

//+(instancetype) sharedInstance;
//
//@property (nonatomic,strong) BmobUser *currentUser;
//@property (nonatomic,strong) NSString *userId;
//@property (nonatomic,strong) NSString *nickname;
//@property (nonatomic,strong) NSString *portraitUri;

/**
 *通过用户id查询其昵称
 */
-(NSString *)getUserNickNameWithUserId:(NSString *)userId;
/**
 *通过用户id查询其昵称
 */
-(NSString *)getUserportraitUriWithUserId:(NSString *)userId;
@end
