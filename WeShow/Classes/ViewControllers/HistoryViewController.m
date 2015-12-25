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
    _datas = [@[@"91",@"91",@"91",@"91",@"91"] mutableCopy];
    _datasDidShow = [@[@"1",@"1",@"0",@"0",@"0"] mutableCopy];
    _cellDatas = [@[@{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic8",
                              @"title":@"五月天鸟巢演唱会",
                              @"address":@"鸟巢",
                              @"distance":@"20km",
                              @"memberNum":@"100人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic7",
                              @"title":@"随手拍北京雾霾",
                              @"address":@"海淀区",
                              @"distance":@"23km",
                              @"memberNum":@"432人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic9",
                              @"title":@"周杰伦演唱会",
                              @"address":@"小巨蛋",
                              @"distance":@"30km",
                              @"memberNum":@"3200人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic1",
                              @"title":@"三里屯发生恐怖袭击，武警持枪戒备",
                              @"address":@"北京",
                              @"distance":@"10km",
                              @"memberNum":@"23人"}},
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic5",
                              @"title":@"第十届北京马拉松",
                              @"address":@"北京",
                              @"distance":@"10km",
                              @"memberNum":@"2321人"}},
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
                               @"pic4",@"imageName",
                               @"滴滴总部遭受出租车司机围堵",@"title",
                               @"滴滴总部",@"address",
                               @"1h 10m",@"distance",
                               @"21345人",@"memberNum",nil];
    NSDictionary *dataDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic5",@"imageName",
                               @"第十届北京马拉松",@"title",
                               @"北京",@"address",
                               @"3h 1.5km",@"distance",
                               @"2123人",@"memberNum",nil];
    NSDictionary *dataDict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic6",@"imageName",
                               @"京郊百车连撞事故现场",@"title",
                               @"京郊",@"address",
                               @"2h 3km",@"distance",
                               @"323人",@"memberNum",nil];
    
    
    IncidentViewNew *test1 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(0,  10, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height - 20)];
    test1.delegate = self;
    [test1 updateDatas:dataDict1];
    [_bottomView.myScroll addSubview:test1];
    
    IncidentViewNew *test2 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width,  5, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height - 10)];
    test2.delegate = self;
    [test2 updateDatas:dataDict2];
    [_bottomView.myScroll addSubview:test2];
    
    IncidentViewNew *test3 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width*2, 0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![[_datasDidShow objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        [_datasDidShow setObject:@"1" atIndexedSubscript:indexPath.row];
        cell.EA_Right = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
        cell.EA_Left = 0;
        [UIView commitAnimations];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuserStr = @"MaintableViewCell";
    MultiIncidentTableViewCell *cell = [[MultiIncidentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[MultiIncidentTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    if ([_datas[indexPath.row] floatValue] == 91) {
        [cell loadStyle2:[_cellDatas objectAtIndex:indexPath.row]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)didClickIncidentViewNew:(IncidentViewNew *)inview{
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
