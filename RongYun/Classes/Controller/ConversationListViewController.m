//
//  ConversationListViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "ConversationListViewController.h"
#import "ChatViewController.h"
@interface ConversationListViewController ()

@end

@implementation ConversationListViewController

+(instancetype) sharedInstance{
    static ConversationListViewController *manager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        //设置显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        //设置需要将哪些类型的会话在会话列表中聚合显示
        [self setCollectionConversationType:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self.tabBarController.tabBar setHidden:NO];
    
    //清除多余的分割线
    [self setExtraCellLineHidden:self.conversationListTableView];
    
    [self refreshConversationTableViewIfNeeded];
}


//清除多余的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *点击会话列表cell的回调
 */
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    
    ChatViewController *chatvc = [[ChatViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:model.senderUserId];
    chatvc.title = model.senderUserId;
    
    [self.navigationController pushViewController:chatvc animated:YES];
    
}
/*!
 在会话列表中，收到新消息的回调
 
 @param notification    收到新消息的notification
 
 @discussion SDK在此方法中有针对消息接收有默认的处理（如刷新等），如果您重写此方法，请注意调用super。
 
 notification的object为RCMessage消息对象，userInfo为NSDictionary对象，其中key值为@"left"，value为还剩余未接收的消息数的NSNumber对象。
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification{
    [super didReceiveMessageNotification:notification];
    
    [self refreshConversationTableViewIfNeeded];
}

@end
