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

@interface MainViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    UIButton * arrowButton;
    UIButton *rightButton;
    UIButton *leftButton;
    PullView *bottomView;
    UIScrollView *mainScrollView;
    PulsingHaloLayer *testLayer1;
    PulsingHaloLayer *testLayer2;
    UIImageView *testDot;
    
    CGPoint originPoint;
    
    CGFloat bottomViewHeight;
    
}
@end

@implementation MainViewController

- (instancetype)init{
    if (self = [super init]) {
        //[MAMapServices sharedServices].apiKey = mapAPIKEY;
        leftButton = [Tools getNavigationItemWithImage:@"map_history"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        rightButton = [Tools getNavigationItemWithImage:@"map_profile"];
        [rightButton addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        //背景地图
        mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        mainScrollView.contentSize = CGSizeMake(640, 640);
        mainScrollView.bounces = NO;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.showsVerticalScrollIndicator = NO;
        UIImageView *scrollViewBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640, 640)];
        scrollViewBackground.image = [UIImage imageNamed:@"map_background"];
        [mainScrollView addSubview:scrollViewBackground];
        [self.view addSubview:mainScrollView];

        
        testDot = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 120, 120)];
        testDot.image = [UIImage imageNamed:@"map_range"];
        [mainScrollView addSubview:testDot];
        
        UIImageView *testDotTag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 21)];
        testDotTag.image = [UIImage imageNamed:@"map_live"];
        testDotTag.EA_CenterX = testDot.frame.size.width/2;
        testDotTag.EA_Bottom = testDot.frame.size.height/2;
        [testDot addSubview:testDotTag];
        
        testLayer1 = [[PulsingHaloLayer alloc]init];
        testLayer1.position = CGPointMake(testDot.frame.size.width/2, testDot.frame.size.height/2);
        testLayer1.radius = 40;
        testLayer1.animationDuration = 1.5;
        testLayer1.pulseInterval = 1.5;
        [testDot.layer addSublayer:testLayer1];
        
        testLayer2 = [[PulsingHaloLayer alloc]init];
        testLayer2.position = CGPointMake(testDot.frame.size.width/2, testDot.frame.size.height/2);
        testLayer2.radius = 70;
        testLayer2.animationDuration = 3;
        testLayer2.pulseInterval = 0;
        [testDot.layer addSublayer:testLayer2];
        
        //可拉起菜单
        bottomViewHeight = self.view.EA_Width * 1.215;
        bottomView = [[PullView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 17 - 64, self.view.EA_Width, bottomViewHeight)];
        bottomView.delegate = self;
        [self.view addSubview:bottomView];
        
        IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(20, bottomView.EA_Width * 0.04 + 10, bottomView.EA_Width - 40, bottomView.EA_Height - bottomView.EA_Width * 0.04 - 50)];
        [bottomView.mainScorll addSubview:test1];
        
        IncidentView *test2 = [[IncidentView alloc]initWithFrame:CGRectMake(20, bottomView.EA_Width * 0.04 + 10, bottomView.EA_Width - 40, bottomView.EA_Height - bottomView.EA_Width * 0.04 - 50)];
        [bottomView.mainScorll addSubview:test2];
        
        IncidentView *test3 = [[IncidentView alloc]initWithFrame:CGRectMake(20, bottomView.EA_Width * 0.04 + 10, bottomView.EA_Width - 40, bottomView.EA_Height - bottomView.EA_Width * 0.04 - 50)];
        [bottomView.mainScorll addSubview:test3];
        

    }
    return self;
}

- (void)testClick
{
    cameraViewController *camerVC = [[cameraViewController alloc]init];
    [self.navigationController presentViewController:camerVC animated:YES completion:^{
        
    }];

}

#pragma mark - PullViewDelegate

- (void)pullViewPositionChange:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            originPoint = [gesture locationInView:self.view];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint point = [gesture locationInView:self.view];
            if ((point.y - originPoint.y) > 20)
            {
                [UIView animateWithDuration:0.5 animations:^{
                bottomView.EA_Top = self.view.frame.size.height - 17;
                bottomView.tapImage.image = [UIImage imageNamed:@"map_pull_up"];
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                bottomView.EA_Top = self.view.frame.size.height - bottomViewHeight;
                bottomView.tapImage.image = [UIImage imageNamed:@"map_pull_down"];
                }];
            }
        
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [gesture locationInView:self.view];
            if (point.y> self.view.frame.size.height - bottomViewHeight && point.y < self.view.frame.size.height - 17) {
                bottomView.EA_Top = point.y;
            }
            break;
        }
            
        default:
            break;
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
