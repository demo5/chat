//
//  FriendesListViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/3.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "FriendesListViewController.h"
#import "AddNewFriendViewController.h"
#import "ChatViewController.h"
@interface FriendesListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *friendsList;
@property (nonatomic,strong) NSMutableArray *fNickname;
@end

@implementation FriendesListViewController
#pragma mark - 懒加载

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.friendsList = [[NSMutableArray alloc] init];
    self.fNickname = [[NSMutableArray alloc] init];

    [self getFriends];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addNewFriends)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreanWidth, 44)];
    self.tableView.tableHeaderView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}
-(void)addNewFriends{
    NSLog(@"添加好友！！！");
    AddNewFriendViewController *newFriendVc = [[AddNewFriendViewController alloc]init];
    newFriendVc.title = @"添加好友";
    [self.navigationController pushViewController:newFriendVc animated:YES];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fNickname.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    RCConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[RCConversationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if(self.fNickname.count <= 0){
        cell.conversationTitle.text = @"没有数据";
    }else{
        cell.conversationTitle.text = self.fNickname[indexPath.row];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatViewController *chatVc = [[ChatViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:self.friendsList[indexPath.row]];
    chatVc.title = self.friendsList[indexPath.row];
    [self.navigationController pushViewController:chatVc animated:YES];

}
#pragma mark -  Others
-(void)getFriends{
    
    BmobUser *currentUser = [BmobUser getCurrentUser];
    //查找_User表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
    //查找_Usr表里面id的数据
    [bquery getObjectInBackgroundWithId:currentUser.objectId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
            NSLog(@"好友获取失败");
        }else{
            //表里有id为0c6db13c的数据 ·
            if (object) {
                //得到好友Id
                self.friendsList = [object objectForKey:@"friendsId"];
                
                //得到好友的昵称
                for (NSString *userId in self.friendsList) {
                    //查找_Usr表里面id的数据
                    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object,NSError *error){
                        if (error){
                            //进行错误处理
                            NSLog(@"好友获取失败");
                        }else{
                            //表里有id为0c6db13c的数据
                            if (object) {
                                //得到好友Id
                                [self.fNickname addObject:[object objectForKey:@"nickname"]];
                                [self.tableView reloadData];
                            }
                        }
                    }];
                }
            }
        }
    }];
}
@end
