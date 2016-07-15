//
//  FriendsInfo.m
//  RongYun
//
//  Created by M on 16/7/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "FriendsInfo.h"

@implementation FriendsInfo


-(instancetype) initWithDictionary:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+(instancetype) frientsInfoWithDictionary:(NSDictionary *)dic{

    return [[self alloc] initWithDictionary:dic];
}


+(NSArray *)friendsInfo{

    NSString *filePath = [DocumentPath stringByAppendingFormat:@"/user_%@.plist",[BmobUser getCurrentUser].objectId];
    NSMutableArray *mArray = [NSMutableArray array];
    if (filePath) {
        
        NSDictionary *dict = [[NSDictionary dictionaryWithContentsOfFile:filePath] objectForKey:@"userFriendsDic"];
        NSArray *keys = [dict allKeys];
        
        for (int i = 0; i<keys.count; i++) {
            NSDictionary *value = [dict objectForKey:[NSString stringWithFormat:@"item %d",i]];
            [mArray addObject:[FriendsInfo frientsInfoWithDictionary:value]];
            
        }
    }
    return mArray;
}

@end
