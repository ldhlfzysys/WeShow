//
//  HistoryViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentView.h"
#import "NewPullView.h"

@interface HistoryViewController : UIViewController<IncidentViewDelegate,NewPullViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *cellDatas;

@end
