//
//  HistoryViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryDetailViewController.h"

@interface HistoryViewController ()
@property (nonatomic,strong)PullView *bottomView;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat bottomViewHeight = self.view.EA_Width * 1.215;
    _bottomView = [[PullView alloc]initWithFrame:CGRectMake(0, 64  , self.view.EA_Width, bottomViewHeight)];
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
    
    self.navigationItem.titleView = [Tools getTitleLab:@"历史实况"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *postBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _bottomView.EA_Bottom + 60, 80, 80)];
    postBtn.EA_CenterX = self.view.EA_Width/2;
    [postBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [postBtn setBackgroundImage:[UIImage imageNamed:@"photo_send_big"] forState:UIControlStateNormal];
    [self.view addSubview:postBtn];

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
