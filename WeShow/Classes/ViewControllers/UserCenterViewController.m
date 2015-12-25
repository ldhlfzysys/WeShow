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
    _datas = [@[@"58",@"324.5",@"144.5",@"219.5",@"219.5"] mutableCopy];
    
    

    
    _bottomView = [[NewPullView alloc]initWithFrame:CGRectMake(0,  0, self.view.EA_Width, self.view.EA_Width + 23 +15)];
    _bottomView.delegate = self;

    _mainTable.tableHeaderView = _bottomView;
    
    /*
     模拟数据
     NSString *imageName = [dict objectForKey:@"imageName"];
     NSString *title = [dict objectForKey:@"title"];
     NSString *address = [dict objectForKey:@"address"];
     NSString *distance = [dict objectForKey:@"distance"];
     NSString *memberNum = [dict objectForKey:@"memberNum"];
     */
    NSDictionary *dataDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic7",@"imageName",
                               @"随手拍北京雾霾",@"title",
                               @"北京",@"address",
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
    
    _cellDatas = [@[@{@"userInfoData":@{
                              @"headImageName":@"head1",
                              @"name":@"老王",
                              @"desc":@"我是隔壁老王",
                              }},
                    @{@"userInfoData":@{
                              @"headImageName":@"head3",
                              @"name":@"Mick",
                              @"desc":@"来关注我吧",
                              },
                      
                      @"imageMultiLineIncidentData":@{
                              @"imageName":@"pic1",
                              @"title":@"三里屯发生恐怖袭击，武警持枪戒备",
                              @"address":@"北京",
                              @"distance":@"10km",
                              @"memberNum":@"23人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"multiIncidentData":@{@"images":@[@"pic1_1",@"pic1_2",@"pic1_3",@"pic1_4",@"pic1_5",@"pic1_1"]}//6个图片
                      },
                    
                    @{@"userInfoData":@{
                              @"headImageName":@"head4",
                              @"name":@"Janel",
                              @"desc":@"游泳爱好者",
                              },
                        @"imageMultiLineIncidentData":@{
                              @"imageName":@"pic8",
                              @"title":@"五月天鸟巢演唱会",
                              @"address":@"鸟巢",
                              @"distance":@"20km",
                              @"memberNum":@"100人"}},
                    
                    @{@"userInfoData":@{
                              @"headImageName":@"head5",
                              @"name":@"Cucii",
                              @"desc":@"战争记着",
                              },
                        @"imageMultiLineIncidentData":@{
                              @"imageName":@"pic7",
                              @"title":@"随手拍北京雾霾",
                              @"address":@"海淀区",
                              @"distance":@"23km",
                              @"memberNum":@"432人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"commontData":@{@"commontLabel":@"oh my god，刚才就有子弹从我旁边飞过，祈祷世界没有战争"}},
                    
                    @{@"userInfoData":@{
                              @"headImageName":@"head6",
                              @"name":@"翠花",
                              @"desc":@"我是志愿者",
                              },
                        @"imageMultiLineIncidentData":@{
                              @"imageName":@"pic9",
                              @"title":@"周杰伦演唱会",
                              @"address":@"小巨蛋",
                              @"distance":@"30km",
                              @"memberNum":@"3200人"},
                      
                      @"onelineViewData":@{@"name":@""},
                      
                      @"commontData":@{@"commontLabel":@"下一个举着圣火跑过来的是我们的刘翔！"}},
                    
                    ] mutableCopy];

    IncidentViewNew *test1 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(0,  0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height )];
    test1.headImage.image = [UIImage imageNamed:@"head1"];
    test1.delegate = self;
    [test1 updateDatas:dataDict1];
    [_bottomView.myScroll addSubview:test1];
    
    IncidentViewNew *test2 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width,  0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
    test2.headImage.image = [UIImage imageNamed:@"head2"];
    test2.delegate = self;
    [test2 updateDatas:dataDict2];
    [_bottomView.myScroll addSubview:test2];
    
    IncidentViewNew *test3 = [[IncidentViewNew alloc]initWithFrame:CGRectMake(_bottomView.myScroll.EA_Width*2, 0, _bottomView.myScroll.EA_Width, _bottomView.myScroll.EA_Height)];
    test3.headImage.image = [UIImage imageNamed:@"head3"];
    test3.delegate = self;
    [test3 updateDatas:dataDict3];
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
    if ([_datas[indexPath.row] floatValue] == 281+ 43.5) {
        [cell loadStyle1:[_cellDatas objectAtIndex:indexPath.row]];
    }else if ([_datas[indexPath.row] floatValue] == 101+ 43.5){
        [cell loadStyle2:[_cellDatas objectAtIndex:indexPath.row]];
    }else if ([_datas[indexPath.row] floatValue] == 219.5){
        [cell loadStyle3:[_cellDatas objectAtIndex:indexPath.row]];
    }else if ([_datas[indexPath.row] floatValue] == 58){
        [cell loadStyle4:[_cellDatas objectAtIndex:indexPath.row]];
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
