//
//  UserInformation.h
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

+(instancetype) sharedInstance;

@property (nonatomic,strong) NSString *nickname;
@end
