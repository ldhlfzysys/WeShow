//
//  UserCenterViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "UserCenterViewController.h"
#import "ProfileViewController.h"
#import "UserIncidentTableViewCell.h"
@interface UserCenterViewController ()
@property(nonatomic,strong)NewPullView *bottomView;
@end

@implementation UserCenterViewController

- (instancetype)init{
    if (self = [super init]) {
        self.view.backgroundColor = UIColorFromRGB(0x373B47);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Tools getTitleLab:@"在发生"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *creatBtn = [Tools getNavigationItemWithImage:@"feed_plus"];
    [creatBtn addTarget:self action:@selector(createClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:creatBtn];
    
//    UIImageView *a = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
//    [self.view addSubview:a];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    _mainTable.backgroundColor = UIColorFromRGB(0x373b47);

    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    /**
     临时数据，用3种高度表示3种展示。
     **/
    _datas = [@[@"68",@"334.5",@"154.5",@"229.5",@"229.5",@"229.5",@"229.5",@"229.5",@"229.5",@"229.5"] mutableCopy];

    
    _bottomView = [[NewPullView alloc]initWithFrame:CGRectMake(0,  0, self.view.EA_Width, self.view.EA_Width + 23 +15)];
    _bottomView.delegate = self;

    _mainTable.tableHeaderView = _bottomView;
    
    IncidentViewNew *test1 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(0,  0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
    test1.delegate = self;
    [_bottomView.myScroll addSubview:test1];
    
    IncidentViewNew *test2 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width,  0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
    test2.delegate = self;
    [_bottomView.myScroll addSubview:test2];
    
    IncidentViewNew *test3 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width*2, 0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
    test3.delegate = self;
    [_bottomView.myScroll addSubview:test3];
    
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
    UserIncidentTableViewCell *cell = [[UserIncidentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[UserIncidentTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    if ([_datas[indexPath.row] floatValue] == 281+ 53.5) {
        [cell loadStyle1];
    }else if ([_datas[indexPath.row] floatValue] == 101+ 53.5){
        [cell loadStyle2];
    }else if ([_datas[indexPath.row] floatValue] == 229.5){
        [cell loadStyle3];
    }else if ([_datas[indexPath.row] floatValue] == 68){
        [cell loadStyle4];
    }
    [cell.bgView setHeadImageClick:^{
        ProfileViewController *pVC = [[ProfileViewController alloc]init];
        [self.navigationController pushViewController:pVC animated:YES];
    }];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)createClick{
    
}

- (void)pullViewNewScrollToIndex:(NSInteger)index
{
    
}

- (void)scrollViewNewDidScroll:(UIScrollView *)scrollView
{
}

- (void)didClickIncidentViewNew:(IncidentViewNew *)inview
{

}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
