//
//  UserInformation.m
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

//+(instancetype) sharedInstance{
//    static UserInformation *manager;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        manager = [[self alloc] init];
//    });
//    return manager;
//}
//
//-(NSString *)userId{
//    return [BmobUser getCurrentUser].objectId;
//}
//
//-(BmobUser *)currentUser{
//    return [BmobUser getCurrentUser];
//}
//
//-(NSString *)nickname{
//    __block NSString *name = [NSString string];
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
//    [bquery getObjectInBackgroundWithId:self.userId block:^(BmobObject *object, NSError *error) {
//        if (!error) {
//            if (object) {
//                name = [object objectForKey:@"nickname"];
//            }
//        }else{
//        
//        }
//    }];
//    return name;
//}
//-(NSString *)portraitUri{
//    __block NSString *uri = [NSString string];
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
//    [bquery getObjectInBackgroundWithId:self.userId block:^(BmobObject *object, NSError *error) {
//        if (!error) {
//            if (object) {
//                uri = [object objectForKey:@"portraitUri"];
//            }
//        }else{
//            
//        }
//    }];
//    return uri;
//}

-(NSString *)getUserNickNameWithUserId:(NSString *)userId{
    __block NSString *nickname = [NSString string];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object, NSError *error) {
        if (!error) {
            if (object) {
                nickname = [object objectForKey:@"nickname"];
            }
        }else{
            
        }
    }];
    return nickname;
}
-(NSString *)getUserportraitUriWithUserId:(NSString *)userId{
    __block NSString *portraitUri = [NSString string];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object, NSError *error) {
        if (!error) {
            if (object) {
                portraitUri = [object objectForKey:@"portraitUri"];
            }
        }else{
            
        }
    }];
    return portraitUri;
}
@end
