//
//  MainViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "MainViewController.h"
#import "MAMapKit/MAMapKit.h"
#import "PulsingHaloLayer.h"
#import "cameraViewController.h"
#import "IncidentView.h"
#import "DotView.h"
#import "CreateViewController.h"
#import "sceneViewController.h"
#import "HistoryViewController.h"
#import "UserCenterViewController.h"

@interface MainViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    UIButton * arrowButton;
    UIButton *rightButton;
    UIButton *leftButton;


    CGPoint originPoint;
    CGFloat bottomViewHeight;
    
    DotView *dot1;
    DotView *dot2;
    DotView *dot3;
}
@property (nonatomic,strong) PullView *bottomView;
@property (strong, nonatomic) UIButton *createVideobutton;
@end

@implementation MainViewController

- (instancetype)init{
    if (self = [super init]) {
        //[MAMapServices sharedServices].apiKey = mapAPIKEY;
        
        leftButton = [Tools getNavigationItemWithImage:@"map_history"];
        [leftButton addTarget:self action:@selector(historyClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        rightButton = [Tools getNavigationItemWithImage:@"map_profile"];
        [rightButton addTarget:self action:@selector(userCenterClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        //背景地图
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _mainScrollView.contentSize = CGSizeMake(2000, 2000);
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        UIImageView *scrollViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2000, 2000)];
        scrollViewBackground.image = [UIImage imageNamed:@"map_background"];
        [_mainScrollView addSubview:scrollViewBackground];
        [self.view addSubview:_mainScrollView];
        [_mainScrollView setContentOffset:CGPointMake(617, 891)];
        

        

        _createVideobutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 24 - 62, self.view.EA_Bottom, 62,62)];
        [_createVideobutton setImage:[UIImage imageNamed:@"video_create"] forState:UIControlStateNormal];
        [_createVideobutton setBackgroundColor:[UIColor clearColor]];
        [_createVideobutton addTarget:self action:@selector(createVideo) forControlEvents:UIControlEventTouchUpInside];
        [_mainScrollView addSubview:_createVideobutton];
        
        
        dot1 = [[DotView alloc]initWithFrame:CGRectMake(613, 981.5, 120, 120)];
        [dot1 loadAnimation:100];
        [_mainScrollView addSubview:dot1];
        __block MainViewController *blockSelf = self;
        [dot1 setClickBlock:^{
            [blockSelf.bottomView scrollToIndex:0];
            [blockSelf showBottomView];
            [blockSelf.mainScrollView setContentOffset:CGPointMake(485, 904) animated:YES];


        }];
        
        dot2 = [[DotView alloc]initWithFrame:CGRectMake(835, 1055, 120, 120)];
        [dot2 loadAnimation:80];
        [_mainScrollView addSubview:dot2];
        [dot2 setClickBlock:^{
            [blockSelf.bottomView scrollToIndex:1];
            [blockSelf showBottomView];
            [blockSelf.mainScrollView setContentOffset:CGPointMake(706, 970) animated:YES];
        }];
        
        dot3 = [[DotView alloc]initWithFrame:CGRectMake(842.5, 900, 120, 120)];
        [dot3 loadAnimation:60];
        [_mainScrollView addSubview:dot3];
        
        [dot3 setClickBlock:^{
            [blockSelf.bottomView scrollToIndex:2];
            [blockSelf showBottomView];
            [blockSelf.mainScrollView setContentOffset:CGPointMake(712, 817) animated:YES];
        }];
        
        //定位和发布按钮
        UIImageView *locationView = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.EA_Height - 20 - 35, 35, 35)];
        locationView.image = [UIImage imageNamed:@"map_positioning"];
        locationView.userInteractionEnabled = YES;
        [self.view addSubview:locationView];
        UITapGestureRecognizer *locationTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationMy)];
        [locationView addGestureRecognizer:locationTap];
        
        UIImageView *myLocation = [[UIImageView alloc]initWithFrame:CGRectMake(796, 970, 30, 30)];
        myLocation.image = [UIImage imageNamed:@"map_location"];
        [_mainScrollView addSubview:myLocation];
        
        UIImageView *createView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.EA_Width - 20 - 70 , self.view.EA_Height - 20 - 70, 70, 70)];
        createView.image = [UIImage imageNamed:@"map_create"];
        createView.userInteractionEnabled = YES;
        [self.view addSubview:createView];
        UITapGestureRecognizer *createTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createNew)];
        [createView addGestureRecognizer:createTap];

        /*
         模拟数据
         NSString *imageName = [dict objectForKey:@"imageName"];
         NSString *mediaLabelStr = [dict objectForKey:@"mediaType"];
         NSString *title = [dict objectForKey:@"title"];
         NSString *address = [dict objectForKey:@"address"];
         NSString *distance = [dict objectForKey:@"distance"];pic
         NSString *memberNum = [dict objectForKey:@"memberNum"];
         */
        NSDictionary *dataDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"pic1",@"imageName",
                                  @"Live",@"mediaType",
                                  @"三里屯发生恐怖袭击，武警持枪戒备",@"title",
                                  @"三里屯",@"address",
                                  @"10m",@"distance",
                                  @"21345人",@"memberNum",nil];
        NSDictionary *dataDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"pic2",@"imageName",
                                   @"Live",@"mediaType",
                                   @"朝阳区万人圣诞马拉松现场",@"title",
                                   @"朝阳区",@"address",
                                   @"1.5km",@"distance",
                                   @"2123人",@"memberNum",nil];
        NSDictionary *dataDict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"pic3",@"imageName",
                                   @"Live",@"mediaType",
                                   @"新浪UDC-M圣诞交换礼物幸福大会",@"title",
                                   @"新浪大厦",@"address",
                                   @"3km",@"distance",
                                   @"323人",@"memberNum",nil];

        
        //可拉起菜单
        bottomViewHeight = self.view.EA_Width * 1.215;
        _bottomView = [[PullView alloc]initWithFrame:CGRectMake(0, 0, self.view.EA_Width, bottomViewHeight)];
        _bottomView.delegate = self;
        _bottomView.EA_Top = self.view.frame.size.height - bottomViewHeight;
        _bottomView.showing = YES;
        [self.view addSubview:_bottomView];
        
        IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(5,  10, _bottomView.mainScorll.EA_Width - 10, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
        test1.delegate = self;
        test1.tag = 0;
        [test1 updateDatas:dataDict1];
        [_bottomView.mainScorll addSubview:test1];
        
        IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(5 + _bottomView.mainScorll.EA_Width,  10, _bottomView.mainScorll.EA_Width - 10, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
        test2.delegate = self;
        test2.tag = 1;
        [test2 updateDatas:dataDict2];
        [_bottomView.mainScorll addSubview:test2];
        
        IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(_bottomView.mainScorll.EA_Width*2 + 5, 10, _bottomView.mainScorll.EA_Width - 10, _bottomView.EA_Height - _bottomView.EA_Width * 0.04 - 50)];
        test3.delegate = self;
        test3.tag = 2;
        [test3 updateDatas:dataDict3];
        [_bottomView.mainScorll addSubview:test3];
        


    }
    return self;
}

- (void)locationMy{
    [self.mainScrollView setContentOffset:CGPointMake(630, 650) animated:YES];
}

//地图上的发布入口
- (void)createNew{
    CreateViewController *createView = [[CreateViewController alloc]init];
    [self.navigationController pushViewController:createView animated:YES];
}

- (void)showBottomView{
    if (_bottomView.showing == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.EA_Top = self.view.frame.size.height - bottomViewHeight;
            _bottomView.tapImage.image = [UIImage imageNamed:@"map_pull_down"];
        }];
        _bottomView.showing = YES;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f---%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

- (void)historyClick{
    HistoryViewController *historyVC = [[HistoryViewController alloc]init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)didClickIncidentView:(IncidentView *)inview
{
    sceneViewController *VC = [[sceneViewController alloc]init];
    [self presentViewController:VC animated:NO completion:^{
    }];
}

- (void)userCenterClick
{
    UserCenterViewController *userVC = [[UserCenterViewController alloc]init];
    [self.navigationController pushViewController:userVC animated:YES];

}

- (void)createVideo
{
    CreateViewController *createView = [[CreateViewController alloc]init];
    [self.navigationController pushViewController:createView animated:YES];
}

#pragma mark - PullViewDelegate

- (void)pullViewScrollToIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [_mainScrollView setContentOffset:CGPointMake(485, 904) animated:YES];
           break;
        }
        case 1:
        {
            [_mainScrollView setContentOffset:CGPointMake(706, 970) animated:YES];
            break;
        }
        case 2:
        {
            [_mainScrollView setContentOffset:CGPointMake(712, 817) animated:YES];
            break;
        }    
        default:
            break;
    }
}

- (void)pullViewPositionChange:(UIPanGestureRecognizer *)gesture
{
    if (_bottomView.showing)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.EA_Top = self.view.frame.size.height - 17;
            _bottomView.tapImage.image = [UIImage imageNamed:@"map_pull_up"];
        }];
        _bottomView.showing = NO;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.EA_Top = self.view.frame.size.height - bottomViewHeight;
            _bottomView.tapImage.image = [UIImage imageNamed:@"map_pull_down"];
        }];
        _bottomView.showing = YES;
    }
}

- (void)pullViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.
//    [MAMapServices sharedServices].apiKey = mapAPIKEY;
//    
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//    _mapView.delegate = self;
//    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
//    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
//    [_mapView setZoomLevel:16.1 animated:YES];
//    
//    //构造圆
//    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.952136, 116.50095) radius:500];
//    
//    //在地图上添加圆
//    [_mapView addOverlay: circle];
//    
//    [self.view addSubview:_mapView];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)refesh{
    [[NetWorkManager sharedManager] sendGetRequest:APIlogin param:nil CallBackHandle:^(id responseObject){
        
    }];
}

////圆形覆盖物
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MACircle class]])
//    {
//        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
//        
//        circleView.lineWidth = 5.f;
//        circleView.strokeColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
//        circleView.fillColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5];
//        //circleView.lineDash = YES;
//        
//        return circleView;
//    }
//    return nil;
//}
//
////位置更新回调
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
//{
//    if(updatingLocation)
//    {
//        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
//    }
//}
//
////用户定位
//- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    MAAnnotationView *view = views[0];
//    
//    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
//        pre.image = [UIImage imageNamed:@"location.png"];
//        pre.lineWidth = 3;
//        pre.lineDashPattern = @[@6, @3];
//        
//        [_mapView updateUserLocationRepresentation:pre];
//        
//        view.calloutOffset = CGPointMake(0, 0);
//    } 
//}

@end
