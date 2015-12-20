//
//  sceneViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "sceneViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface sceneViewController()
@property (strong,nonatomic) NSArray *mediaURLs;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@property (strong,nonatomic) CAShapeLayer *progressLayer;

@property (strong, nonatomic) UIButton *likebutton;
@property (strong, nonatomic) UIButton *forbidBarragebutton;
@property (strong, nonatomic) UIButton *createVideobutton;

@property (assign ,nonatomic) NSInteger currentNum;


@end

@implementation sceneViewController

- (void)viewDidLoad
{
    // the video player
    [self fetchMediaUrl];
    
    self.currentNum = 0;
    [self initVideoPlayer];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + STATUSBAR.size.height, 25,25)];
    [backbutton setImage:[UIImage imageNamed:@"video_back.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    UIButton *userImagebutton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.EA_Bottom - 20 - 30, 30,30)];
    [userImagebutton setImage:[UIImage imageNamed:@"video_profile.png"] forState:UIControlStateNormal];
    [userImagebutton setBackgroundColor:[UIColor clearColor]];
    [userImagebutton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userImagebutton];
    
    UIButton *userNameButton = [[UIButton alloc]initWithFrame:CGRectMake(20 + 30 + 7, self.view.EA_Bottom - 20 - 30, 80,30)];
    [userNameButton setTitle:@"Jean Hanson" forState:UIControlStateNormal];
    [userNameButton setBackgroundColor:[UIColor clearColor]];
    [userNameButton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userNameButton];
    
    _createVideobutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 24 - 62, self.view.EA_Bottom - 24 - 62, 62,62)];
    [_createVideobutton setImage:[UIImage imageNamed:@"video_create.png"] forState:UIControlStateNormal];
    [_createVideobutton setBackgroundColor:[UIColor clearColor]];
    [_createVideobutton addTarget:self action:@selector(createVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_createVideobutton];
    
    UIButton *skipbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 20 - 40, _createVideobutton.EA_Top - 18 - 40, 40,40)];
    [skipbutton setImage:[UIImage imageNamed:@"video_next.png"] forState:UIControlStateNormal];
    [skipbutton setBackgroundColor:[UIColor clearColor]];
    [skipbutton addTarget:self action:@selector(playerItemDidReachEnd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipbutton];
    
    _likebutton = [[UIButton alloc]initWithFrame:CGRectMake(_createVideobutton.EA_Left - 19 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [_likebutton setImage:[UIImage imageNamed:@"video_like.png"] forState:UIControlStateNormal];
    [_likebutton setBackgroundColor:[UIColor clearColor]];
    [_likebutton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likebutton];
    
    UIButton *sendBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(_likebutton.EA_Left -10 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [sendBarragebutton setImage:[UIImage imageNamed:@"video_barrage.png"] forState:UIControlStateNormal];
    [sendBarragebutton setBackgroundColor:[UIColor clearColor]];
    [sendBarragebutton addTarget:self action:@selector(sendBarrage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBarragebutton];
    
    _forbidBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(sendBarragebutton.EA_Left -10 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [_forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off.png"] forState:UIControlStateNormal];
    [_forbidBarragebutton setBackgroundColor:[UIColor clearColor]];
    [_forbidBarragebutton addTarget:self action:@selector(forbidBarrage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forbidBarragebutton];
    
    _progressLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_progressLayer];
    
    CGPoint point = [_createVideobutton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:33.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth = 2;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.avPlayer play];
    [self startAnimation];
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)initVideoPlayer
{
    self.avPlayer = [AVPlayer playerWithURL:[NSURL fileURLWithPath:[self.mediaURLs objectAtIndex:_currentNum]]];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    //self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.avPlayerLayer.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    [self.view.layer addSublayer:self.avPlayerLayer];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    self.currentNum += 1;
    [self.avPlayer pause];
    [self kickbackProgressAnimation];
    [_progressLayer removeAllAnimations];
    [self.avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[self.mediaURLs objectAtIndex:_currentNum]]]];
    
    [self.avPlayer play];
    [self startAnimation];
}

- (void)fetchMediaUrl
{
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo45.mov"];
    NSString *path2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo45.mov"];
    NSString *path3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo46.mov"];
    NSString *path4 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo50.mov"];
    NSString *path5 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo52.mov"];
    NSString *path6 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo72.mov"];
    NSString *path7 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo79.mov"];
    
    self.mediaURLs = [NSArray arrayWithObjects:path1, path2,path3,path4,path5,path6,path7,@"8",@"9",@"10",nil];
}

- (void) startAnimation
{
    CGPoint point = [_createVideobutton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:33.5 startAngle:3.5*M_PI endAngle:1.5*M_PI clockwise:NO];
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth = 2;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CMTime itemTime = [[self.avPlayer currentItem] asset].duration;
    animation.duration = itemTime.value/itemTime.timescale;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0];
    
    [_progressLayer addAnimation:animation forKey:@"CircleAnimation"];
}

- (void)kickbackProgressAnimation
{
    CFTimeInterval pausedTime = [_progressLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _progressLayer.timeOffset = pausedTime;
}

- (void)userProfile
{
    
}

- (void)createVideo
{
    
}

- (void)like
{
    [_likebutton setImage:[UIImage imageNamed:@"video_highlight.png"] forState:UIControlStateNormal];
}

-(void)sendBarrage
{
    
}

-(void)forbidBarrage
{
    
}

@end
