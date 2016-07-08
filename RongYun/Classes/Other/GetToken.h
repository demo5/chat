//
//  GetToken.h
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetToken : NSObject
/**
*  获取token的方法
*
*  @param userId  用户唯一Id
*  @param username  用户昵称
*  @param portraitUri 头像网络地址
*
*  @return 请求到的token
*/
+(NSString *)getTokenWithUserId:userId userName:(NSString *)username portraitUri:(NSString *)portraitUri;
@end
