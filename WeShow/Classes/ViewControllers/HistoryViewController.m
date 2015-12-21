//
//  HistoryViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryDetailViewController.h"
#import "MultiIncidentTableViewCell.h"

@interface HistoryViewController ()
@property (nonatomic,strong)NewPullView *bottomView;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    _mainTable.backgroundColor = UIColorFromRGB(0x373b47);
    
    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    /**
     临时数据，用3种高度表示3种展示。
     **/
    _datas = [@[@"101",@"101",@"101",@"101",@"101",@"101",@"101",@"101",@"101"] mutableCopy];
    
    CGFloat bottomViewHeight = self.view.EA_Width * 1.215;
    _bottomView = [[NewPullView alloc]initWithFrame:CGRectMake(0, 64, self.view.EA_Width, bottomViewHeight)];
    _bottomView.delegate = self;
    _mainTable.tableHeaderView = _bottomView;
    
    IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(10,  10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test1.delegate = self;
    [_bottomView.myScroll addSubview:test1];
    
    IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(10 + _bottomView.myScroll.EA_Width,  10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test2.delegate = self;
    [_bottomView.myScroll addSubview:test2];
    
    IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width*2 + 10, 10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test3.delegate = self;
    [_bottomView.myScroll addSubview:test3];
    
    self.navigationItem.titleView = [Tools getTitleLab:@"历史实况"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];


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
    MultiIncidentTableViewCell *cell = [[MultiIncidentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[MultiIncidentTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    if ([_datas[indexPath.row] floatValue] == 101) {
        [cell loadStyle2];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)didClickIncidentView:(IncidentView *)inview{
    HistoryDetailViewController *detailVC = [[HistoryDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)pullViewScrollToIndex:(NSInteger)index
{
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
