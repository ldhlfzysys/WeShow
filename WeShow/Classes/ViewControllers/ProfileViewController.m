//
//  ProfileViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Tools getTitleLab:@"我"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *moreBtn = [Tools getNavigationItemWithImage:@"profile_more"];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    _headView = [[ProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, 250)];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, self.view.EA_Width, self.view.EA_Height + 64)];
    _mainTable.backgroundColor = UIColorFromRGB(0x373b47);
    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    _mainTable.tableHeaderView = _headView;
    /**
     临时数据，用3种高度表示3种展示。
     **/
    _datas = [@[@"271",@"91",@"166",@"166"] mutableCopy];
    _cellDatas = [@[@{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic1",
                              @"title":@"微博创新大赛",
                              @"address":@"微博创新大赛",
                              @"distance":@"10m",
                              @"memberNum":@"232人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"multiIncidentData":@{@"images":@[@"pic5",@"pic6",@"pic7",@"pic8",@"pic9",@"pic10"]}//6个图片
                      },
                    
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic2",
                              @"title":@"苹果发布会",
                              @"address":@"苹果大厦",
                              @"distance":@"10km",
                              @"memberNum":@"123人"}},
                    
                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic3",
                              @"title":@"野外探险",
                              @"address":@"野外",
                              @"distance":@"21km",
                              @"memberNum":@"3人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"commontData":@{@"commontLabel":@"野外生存21天，老王我一天抓了3头羊！"}},

                    @{@"imageMultiLineIncidentData":@{
                              @"imageName":@"pic4",
                              @"title":@"去看北极光",
                              @"address":@"南极",
                              @"distance":@"100km",
                              @"memberNum":@"12人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"commontData":@{@"commontLabel":@"一整夜都没睡，太美太美太美了！！！"}},
                    
                    ] mutableCopy];
    
    
    /*
     模拟数据
     NSString *topImageName = [dict objectForKey:@"topImageName"];
     NSString *headImageName = [dict objectForKey:@"headImageName"];
     NSString *desc = [dict objectForKey:@"desc"];

     NSString *viewerNum = [dict objectForKey:@"viewerNum"];
     NSString *viewerdesc = [dict objectForKey:@"viewerdesc"];
     
     NSString *follwerNum = [dict objectForKey:@"follwerNum"];
     NSString *follwerdesc = [dict objectForKey:@"follwerdesc"];
     
     NSString *historyNum = [dict objectForKey:@"historyNum"];
     NSString *historydesc = [dict objectForKey:@"historydesc"];
     */
    NSDictionary *dataDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic1",@"topImageName",
                               @"head1",@"headImageName",
                               @"欢迎来到我的个人主页，喜欢我的直播就关注我吧！让你足不出户，看尽天下事！",@"desc",
                               @"4532",@"viewerNum",
                               @"",@"viewerdesc",
                               @"297",@"follwerNum",
                               @"",@"follwerdesc",
                               @"113",@"historyNum",
                               @"",@"historydesc",nil];
    [_headView updateDatas:dataDict1];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y + 64;// 0~184
    CGFloat barAlpha = y/184;
    UIColor * color = [UIColor colorWithRed:73/255.0 green:82/255.0 blue:98/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:barAlpha]];
    [_headView didScroll:y];
    
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
    if ([_datas[indexPath.row] floatValue] == 271) {
        [cell loadStyle1:[_cellDatas objectAtIndex:indexPath.row]];
    }else if ([_datas[indexPath.row] floatValue] == 91){
        [cell loadStyle2:[_cellDatas objectAtIndex:indexPath.row]];
    }else if ([_datas[indexPath.row] floatValue] == 166){
        [cell loadStyle3:[_cellDatas objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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


- (void)moreClick{
    
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
