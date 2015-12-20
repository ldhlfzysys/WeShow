//
//  UserCenterViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "UserCenterViewController.h"
#import "ProfileViewController.h"
@interface UserCenterViewController ()
@property(nonatomic,strong)PullView *bottomView;
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
    
    
    CGFloat bottomViewHeight = self.view.EA_Width * 1.215;
    _bottomView = [[PullView alloc]initWithFrame:CGRectMake(0, -17, self.view.EA_Width, bottomViewHeight)];
    _bottomView.delegate = self;
    _bottomView.showing = YES;
    [self.view addSubview:_bottomView];
    
    IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(10,  10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test1.delegate = self;
    [_bottomView.mainScorll addSubview:test1];
    
    IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(10 + _bottomView.mainScorll.EA_Width,  10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test2.delegate = self;
    [_bottomView.mainScorll addSubview:test2];
    
    IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(_bottomView.mainScorll.EA_Width*2 + 10, 10, _bottomView.mainScorll.EA_Width - 20, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
    test3.delegate = self;
    [_bottomView.mainScorll addSubview:test3];
    
}

- (void)createClick{
    
}

- (void)pullViewScrollToIndex:(NSInteger)index
{
    
}

- (void)didClickIncidentView:(IncidentView *)inview
{
    ProfileViewController *pVC = [[ProfileViewController alloc]init];
    [self.navigationController pushViewController:pVC animated:YES];
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
