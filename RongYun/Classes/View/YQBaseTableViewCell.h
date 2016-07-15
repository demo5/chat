//
//  YQBaseTableViewCell.h
//  RongYun
//
//  Created by M on 16/7/12.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end
