//
//  AddNewFriendViewController.m
//  RongYun
//
//  Created by YoKing on 16/7/5.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "AddNewFriendViewController.h"

@interface AddNewFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *listArr;
@end

@implementation AddNewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.tableview.tableHeaderView = [self tableViewHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
#pragma table view  -----  data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    
    return cell;
}
#pragma others

-(UIView *)tableViewHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreanWidth, 44)];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 2, ScreanWidth-60, 40)];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(ScreanWidth-50, 2, 40, 40)];
    [searchBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchPeople) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:searchBtn];
    [view addSubview:textField];
    
    return view;
}

-(void)searchPeople{
    NSLog(@"搜索好友！！--------");
    self.listArr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    [self.tableview reloadData];
    
}









@end
