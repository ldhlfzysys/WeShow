//
//  HistoryDetailViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@end
