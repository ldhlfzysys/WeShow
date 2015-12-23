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
    _datas = [@[@"101",@"101",@"101",@"101",@"101"] mutableCopy];
    _cellDatas = [@[@{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic4",
                              @"title":@"北极光",
                              @"address":@"南极",
                              @"distance":@"23km",
                              @"memberNum":@"12人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic5",
                              @"title":@"夏威夷冲浪节",
                              @"address":@"夏威夷",
                              @"distance":@"23km",
                              @"memberNum":@"100人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic6",
                              @"title":@"张家界",
                              @"address":@"",
                              @"distance":@"",
                              @"memberNum":@""}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic7",
                              @"title":@"",
                              @"address":@"",
                              @"distance":@"",
                              @"memberNum":@""}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic8",
                              @"title":@"",
                              @"address":@"",
                              @"distance":@"",
                              @"memberNum":@""}},
                    ] mutableCopy];
    
    CGFloat bottomViewHeight = self.view.EA_Width * 1.215;
    _bottomView = [[NewPullView alloc]initWithFrame:CGRectMake(0, 64, self.view.EA_Width, bottomViewHeight)];
    _bottomView.delegate = self;
    _mainTable.tableHeaderView = _bottomView;
    
    /*
     模拟数据
     NSString *imageName = [dict objectForKey:@"imageName"];
     NSString *mediaLabelStr = [dict objectForKey:@"mediaType"];
     NSString *title = [dict objectForKey:@"title"];
     NSString *address = [dict objectForKey:@"address"];
     NSString *distance = [dict objectForKey:@"distance"];
     NSString *memberNum = [dict objectForKey:@"memberNum"];
     */
    NSDictionary *dataDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic1",@"imageName",
                               @"Live",@"mediaType",
                               @"微博发布会",@"title",
                               @"新浪大厦",@"address",
                               @"1h 10m",@"distance",
                               @"21345人",@"memberNum",nil];
    NSDictionary *dataDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic2",@"imageName",
                               @"Live",@"mediaType",
                               @"苹果发布会",@"title",
                               @"苹果大厦",@"address",
                               @"3h 1.5km",@"distance",
                               @"2123人",@"memberNum",nil];
    NSDictionary *dataDict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic3",@"imageName",
                               @"Live",@"mediaType",
                               @"清华运动会",@"title",
                               @"清华大学",@"address",
                               @"2h 3km",@"distance",
                               @"323人",@"memberNum",nil];
    
    IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(10,  10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test1.delegate = self;
    [test1 updateDatas:dataDict1];
    [_bottomView.myScroll addSubview:test1];
    
    IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(10 + _bottomView.myScroll.EA_Width,  10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test2.delegate = self;
    [test2 updateDatas:dataDict2];
    [_bottomView.myScroll addSubview:test2];
    
    IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width*2 + 10, 10, _bottomView.myScroll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test3.delegate = self;
    [test3 updateDatas:dataDict3];
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
        [cell loadStyle2:[_cellDatas objectAtIndex:indexPath.row]];
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
