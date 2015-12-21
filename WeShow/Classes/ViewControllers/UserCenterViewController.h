//
//  UserCenterViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "IncidentViewNew.h"
#import "NewPullView.h"
@interface UserCenterViewController : UIViewController<IncidentViewNewDelegate,NewPullViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@end
