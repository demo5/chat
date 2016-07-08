//
//  ChatViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "ChatViewController.h"
#import "ConversationListViewController.h"


@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self notifyUpdateUnreadMessageCount];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)didSendMessage:(NSInteger)stauts
               content:(RCMessageContent *)messageCotent{
    
    [[ConversationListViewController sharedInstance] refreshConversationTableViewIfNeeded];
}



@end
