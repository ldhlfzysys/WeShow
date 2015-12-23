//
//  CreateViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat bottomViewHeight = self.view.EA_Width * 1.215;
    _bottomView = [[PullView alloc]initWithFrame:CGRectMake(0, -17+64, self.view.EA_Width, bottomViewHeight)];
    _bottomView.delegate = self;
    _bottomView.showing = YES;
    [self.view addSubview:_bottomView];
    
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
                               @"10m",@"distance",
                               @"21345人",@"memberNum",nil];
    NSDictionary *dataDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic2",@"imageName",
                               @"Live",@"mediaType",
                               @"苹果发布会",@"title",
                               @"苹果大厦",@"address",
                               @"1.5km",@"distance",
                               @"2123人",@"memberNum",nil];
    NSDictionary *dataDict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic3",@"imageName",
                               @"Live",@"mediaType",
                               @"清华运动会",@"title",
                               @"清华大学",@"address",
                               @"3km",@"distance",
                               @"323人",@"memberNum",nil];
    
    IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(10,  10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test1.delegate = self;
    [test1 updateDatas:dataDict1];
    [_bottomView.mainScorll addSubview:test1];
    
    IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(10 + _bottomView.mainScorll.EA_Width,  10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test2.delegate = self;
    [test2 updateDatas:dataDict2];
    [_bottomView.mainScorll addSubview:test2];
    
    IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(_bottomView.mainScorll.EA_Width*2 + 10, 10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test3.delegate = self;
    [test3 updateDatas:dataDict3];
    [_bottomView.mainScorll addSubview:test3];
    
    self.navigationItem.titleView = [Tools getTitleLab:@"创建实况"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *postBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _bottomView.EA_Bottom + 60, 80, 80)];
    postBtn.EA_CenterX = self.view.EA_Width/2;
    [postBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [postBtn setBackgroundImage:[UIImage imageNamed:@"photo_send_big"] forState:UIControlStateNormal];
    [self.view addSubview:postBtn];
    
    
}

- (void)postBtnClick{
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pullViewScrollToIndex:(NSInteger)index
{
    
}

- (void)didClickIncidentView:(IncidentView *)inview
{
    sceneViewController *VC = [[sceneViewController alloc]init];
    [self presentViewController:VC animated:NO completion:^{
    }];
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
