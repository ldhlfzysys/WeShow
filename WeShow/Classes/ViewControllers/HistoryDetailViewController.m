//
//  HistoryDetailViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/19.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "HistoryDetailTableViewCell.h"
#import "HistoryHeadView.h"

@interface HistoryDetailViewController ()
@property(nonatomic,strong)HistoryHeadView *headView;

@end

@implementation HistoryDetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.titleView = [Tools getTitleLab:@"历史实况"];
    UIButton *backBtn = [Tools getNavigationItemWithImage:@"video_back"];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *rightButton = [Tools getNavigationItemWithImage:@"map_profile"];
    [rightButton addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, self.view.EA_Width, self.view.EA_Height + 64)];
    _mainTable.backgroundColor = UIColorFromRGB(0x373b47);
    
    _mainTable.delegate = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    /**
     临时数据，用3种高度表示3种展示。
     **/
    _datas = [@[@"105",@"105",@"105",@"105",@"105"] mutableCopy];
    _cellDatas = [@[@{
                        @"headImageName":@"head1",
                        @"name":@"killer",
                        @"likeNum":@"112",
                        @"comment":@"asdfjsakdjflkasjdfklasjdflkjsadlkfjalksdjfklasdjfaslkdf"},
                    @{
                        @"headImageName":@"head2",
                        @"name":@"ddd",
                        @"likeNum":@"33",
                        @"comment":@"asdfkjasdklfjaslkdjfksdjfklsajdflkajsdlkfj"},
                    @{
                        @"headImageName":@"head3",
                        @"name":@"老王",
                        @"likeNum":@"323",
                        @"comment":@"cccccccccccasdcasdcasdcasdcasdcsda"},
                    @{
                        @"headImageName":@"head4",
                        @"name":@"小明",
                        @"likeNum":@"543",
                        @"comment":@"asdfjwejflksjdflkjasdklfjalks"},
                    @{
                        @"headImageName":@"head5",
                        @"name":@"俊凯",
                        @"likeNum":@"232",
                        @"comment":@"qweqwefsadfqweffqwef"},

                    ] mutableCopy];

    
    NSDictionary *dataDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pic1",@"imageName",
                               @"Live",@"mediaType",
                               @"微博发布会",@"title",
                               @"新浪大厦",@"address",
                               @"1h 10m",@"distance",
                               @"21345人",@"memberNum",nil];
    
    _headView = [[HistoryHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, 864)];
    [_headView updateDatas:dataDict1];
    _mainTable.tableHeaderView = _headView;
    
    _commentView = [[CommentPostView alloc]initWithFrame:CGRectMake(0, self.view.EA_Height - 50, self.view.EA_Width, 50)];
    _commentView.EA_Top = self.view.EA_Height;
    _commentView.commentFiled.delegate = self;
    __block HistoryDetailViewController *blockSelf = self;
    [_commentView setPostBtnBlock:^{
        [blockSelf.commentView.commentFiled resignFirstResponder];
        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        [blockSelf.datas addObject:@"105"];
        NSString *comment = blockSelf.commentView.commentFiled.text;
        [blockSelf.cellDatas insertObject:@{
                                           @"headImageName":@"head5",
                                           @"name":@"俊凯",
                                           @"likeNum":@"232",
                                           @"comment":comment} atIndex:0];
        [blockSelf.mainTable reloadData];
    }];
    [self.view addSubview:_commentView];
    
}

- (void)keyBoardShow:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    _commentView.EA_Bottom = self.view.EA_Height + yOffset;
    
}

- (void)keyBoardHide:(NSNotification *)noti{
        _commentView.EA_Bottom = self.view.EA_Height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y + 64;// 0~184
    CGFloat barAlpha = y/864;
    UIColor * color = [UIColor colorWithRed:73/255.0 green:82/255.0 blue:98/255.0 alpha:1];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:barAlpha]];
    if (y>664) {
        [UIView animateWithDuration:0.5 animations:^{
            _commentView.EA_Top = self.view.EA_Height - 50;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _commentView.EA_Top = self.view.EA_Height;
        }];
    }
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
    HistoryDetailTableViewCell *cell = [[HistoryDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserStr];
    if (cell == nil) {
        cell = [[HistoryDetailTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, self.view.EA_Height)];
    }else{
        cell.EA_Width = SCREEN_WIDTH;
    }
    [cell loadStyle1:[_cellDatas objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
