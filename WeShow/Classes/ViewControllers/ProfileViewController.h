//
//  ProfileViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiIncidentTableViewCell.h"
#import "ProfileHeaderView.h"

@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)ProfileHeaderView *headView;
@end
