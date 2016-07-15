//
//  FriendsInfo.h
//  RongYun
//
//  Created by M on 16/7/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsInfo : NSObject
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *portraitUri;


-(instancetype) initWithDictionary:(NSDictionary *)dic;


+(instancetype) frientsInfoWithDictionary:(NSDictionary *)dic;

/**
 *从plist中加载数据
 */
+(NSArray *)friendsInfo;
@end
