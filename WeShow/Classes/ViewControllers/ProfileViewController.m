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
    _datas = [@[@"281",@"101",@"176",@"176",@"176",@"176",@"176",@"176",@"176"] mutableCopy];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y + 64;// 0~184
    CGFloat barAlpha = y/184;
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
    MultiIncidentTableViewCell *cell = [[MultiIncidentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[MultiIncidentTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    if ([_datas[indexPath.row] floatValue] == 281) {
        [cell loadStyle1];
    }else if ([_datas[indexPath.row] floatValue] == 101){
        [cell loadStyle2];
    }else if ([_datas[indexPath.row] floatValue] == 176){
        [cell loadStyle3];
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
