//
//  HistoryViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentViewNew.h"
#import "NewPullView.h"

@interface HistoryViewController : UIViewController<IncidentViewNewDelegate,NewPullViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *datasDidShow;
@property (nonatomic,strong)NSMutableArray *cellDatas;

@end
