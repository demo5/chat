//
//  UserInformation.m
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

+(instancetype) sharedInstance{
    static UserInformation *manager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)setNickname:(NSString *)nickname{
    _nickname = nickname;
}
@end
