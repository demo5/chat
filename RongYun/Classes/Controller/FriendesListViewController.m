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
#import "FriendsInfo.h"
#import "YQBaseTableViewCell.h"
#import "UIButton+WebCache.h"

@interface FriendesListViewController ()<UITableViewDelegate,UITableViewDataSource,SDWebImageManagerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *friendsList;
@end

@implementation FriendesListViewController
#pragma mark - 懒加载
-(NSArray *)friendsList{
    if (!_friendsList) {
        _friendsList = [FriendsInfo friendsInfo];
    }
    return _friendsList;
}
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    

//    [self getFriends];
//    [self jiedang];
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
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    //清除多余的分割线
    [self setExtraCellLineHidden:self.tableView];
}
-(void)addNewFriends{
    NSLog(@"添加好友！！！");
    AddNewFriendViewController *newFriendVc = [[AddNewFriendViewController alloc]init];
    newFriendVc.title = @"添加好友";
    [self.navigationController pushViewController:newFriendVc animated:YES];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    YQBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YQBaseTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    FriendsInfo *info = self.friendsList[indexPath.row];
    cell.nickname.text = info.nickname;
    
    [cell.headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:info.portraitUri] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_portrait"] options:SDWebImageRetryFailed];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}
#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FriendsInfo *info = self.friendsList[indexPath.row];
    ChatViewController *chatVc = [[ChatViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:info.objectId];
    chatVc.title = info.nickname;
    [self.navigationController pushViewController:chatVc animated:YES];

}
#pragma mark -  Others
//-(void)getFriends{
//    
//    BmobUser *currentUser = [BmobUser getCurrentUser];
//    //查找_User表
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
//    //查找_Usr表里面id的数据
//    [bquery getObjectInBackgroundWithId:currentUser.objectId block:^(BmobObject *object,NSError *error){
//        if (error){
//            //进行错误处理
//            NSLog(@"好友获取失败");
//        }else{
//            //表里有id为0c6db13c的数据 ·
//            if (object) {
//                //得到好友Id
//                self.friendsList = [object objectForKey:@"friendsId"];
//                
//                //得到好友的昵称
//                for (NSString *userId in self.friendsList) {
//                    //查找_Usr表里面id的数据
//                    [bquery getObjectInBackgroundWithId:userId block:^(BmobObject *object,NSError *error){
//                        if (error){
//                            //进行错误处理
//                            NSLog(@"好友获取失败");
//                        }else{
//                            //表里有id为0c6db13c的数据
//                            if (object) {
//                                //得到好友Id
//                                [self.fNickname addObject:[object objectForKey:@"nickname"]];
//                                [self.tableView reloadData];
//                            }
//                        }
//                    }];
//                }
//            }
//        }
//    }];
//}

//-(void)jiedang{
//
//    NSString *filePath = [DocumentPath stringByAppendingFormat:@"/user_%@.plist",[UserInformation sharedInstance].userId];
//    NSLog(@"路径-----path ---- :%@",filePath);
//    if (filePath) {
//        NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        NSLog(@"文件内容---------： %@",root);
//        
//    }else{
//        [self getFriends];
//    }
//}
//清除多余的分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end
