//
//  HistoryDetailViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentPostView.h"
@interface HistoryDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *mainTable;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *cellDatas;
@property (nonatomic,strong)CommentPostView *commentView;
@end
