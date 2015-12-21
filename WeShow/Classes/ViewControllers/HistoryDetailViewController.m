//
//  HistoryDetailViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryDetailTableViewCell.h"
#import "HistoryHeadView.h"
@interface HistoryDetailViewController ()
@property(nonatomic,strong)HistoryHeadView *headView;

@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Tools getTitleLab:@"历史实况"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *rightButton = [Tools getNavigationItemWithImage:@"map_profile"];
    [rightButton addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, self.view.EA_Width, self.view.EA_Height + 64)];
    _mainTable.backgroundColor = UIColorFromRGB(0x373b47);
    
    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    /**
     临时数据，用3种高度表示3种展示。
     **/
    _datas = [@[@"115",@"115",@"115",@"115",@"115",@"115",@"115",@"115"] mutableCopy];
    
    _headView = [[HistoryHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, 864)];
    _mainTable.tableHeaderView = _headView;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y + 64;// 0~184
    CGFloat barAlpha = y/864;
    UIColor * color = [UIColor colorWithRed:73/255.0 green:82/255.0 blue:98/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:barAlpha]];
}

#pragma mark - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_datas[indexPath.row] floatValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuserStr = @"MaintableViewCell";
    HistoryDetailTableViewCell *cell = [[HistoryDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[HistoryDetailTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    [cell loadStyle1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    UIColor * color = [UIColor colorWithRed:73/255.0 green:82/255.0 blue:98/255.0 alpha:1];

    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIColor * color = [UIColor colorWithRed:73/255.0 green:82/255.0 blue:98/255.0 alpha:1];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
