//
//  sceneViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "sceneViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "barrageItemView.h"

#define ITEMTAG 154

@interface sceneViewController()
@property (strong,nonatomic) NSArray *mediaURLs;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (assign, nonatomic) BOOL isHold;

@property (strong,nonatomic) CAShapeLayer *progressLayer;

@property (strong, nonatomic) UIButton *likebutton;
@property (strong, nonatomic) UIButton *forbidBarragebutton;
@property (strong, nonatomic) UIButton *createVideobutton;
@property (strong, nonatomic) UIButton *userImagebutton;
@property (strong, nonatomic) UIButton *userNameButton;

@property (strong,nonatomic) UIImageView *toastView;
@property (assign, nonatomic) BOOL liked;
@property (assign, nonatomic) BOOL forbidenBarrage;
@property (strong, nonatomic) UIView *allBarrageView;
@property (strong, nonatomic) UITextField *barrageTextField;

@property (assign ,nonatomic) NSInteger currentNum;


@property (strong,nonatomic) NSTimer *barragetimer;
@property (assign, nonatomic) NSInteger curbarrageIndex;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation sceneViewController

- (void)viewDidLoad
{
    _isHold = NO;
    // the video player
    [self fetchMediaUrl];
    
    self.currentNum = 0;
    [self initVideoPlayer];
    
    self.barrageTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.barrageTextField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    
    self.barrageTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.barrageTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.barrageTextField.returnKeyType = UIReturnKeyDone;
    self.barrageTextField.clearButtonMode = UITextFieldViewModeWhileEditing; 
    
    self.barrageTextField.delegate = self;
    
    _allBarrageView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUSBAR.size.height + 40, self.view.EA_Width, _createVideobutton.EA_Top - 98 - STATUSBAR.size.height)];
    [self.view addSubview:_allBarrageView];
    
    UIView *myControlView = [[UIView alloc]initWithFrame:self.view.frame];
    //[myControlView setBackgroundColor:[UIColor clearColor]];
    myControlView.userInteractionEnabled = YES;
    [self.view addSubview:myControlView];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdVideo:)];
    longPressGr.minimumPressDuration = 0.2;
    
    [myControlView addGestureRecognizer:longPressGr];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + STATUSBAR.size.height, 25,25)];
    [backbutton setImage:[UIImage imageNamed:@"video_back.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:backbutton];
    
    _userImagebutton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.EA_Bottom - 20 - 30, 30,30)];
    [_userImagebutton setImage:[UIImage imageNamed:@"video_profile.png"] forState:UIControlStateNormal];
    [_userImagebutton setBackgroundColor:[UIColor clearColor]];
    [_userImagebutton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:_userImagebutton];
    
    _userNameButton = [[UIButton alloc]initWithFrame:CGRectMake(20 + 30 + 7, self.view.EA_Bottom - 20 - 30, 80,30)];
    [_userNameButton setTitle:@"Jean Hanson" forState:UIControlStateNormal];
    [_userNameButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_userNameButton setBackgroundColor:[UIColor clearColor]];
    [_userNameButton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:_userNameButton];
    
    _createVideobutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 24 - 62, self.view.EA_Bottom - 24 - 62, 62,62)];
    [_createVideobutton setImage:[UIImage imageNamed:@"video_create.png"] forState:UIControlStateNormal];
    [_createVideobutton setBackgroundColor:[UIColor clearColor]];
    [_createVideobutton addTarget:self action:@selector(createVideo) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:_createVideobutton];
    
    UIButton *skipbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 20 - 40, _createVideobutton.EA_Top - 18 - 40, 40,40)];
    [skipbutton setImage:[UIImage imageNamed:@"video_next.png"] forState:UIControlStateNormal];
    [skipbutton setBackgroundColor:[UIColor clearColor]];
    [skipbutton addTarget:self action:@selector(playerItemDidReachEnd:) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:skipbutton];
    
    _likebutton = [[UIButton alloc]initWithFrame:CGRectMake(_createVideobutton.EA_Left - 19 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [_likebutton setImage:[UIImage imageNamed:@"video_like.png"] forState:UIControlStateNormal];
    [_likebutton setBackgroundColor:[UIColor clearColor]];
    [_likebutton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:_likebutton];
    
    UIButton *sendBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(_likebutton.EA_Left -10 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [sendBarragebutton setImage:[UIImage imageNamed:@"video_barrage.png"] forState:UIControlStateNormal];
    [sendBarragebutton setBackgroundColor:[UIColor clearColor]];
    [sendBarragebutton addTarget:self action:@selector(sendBarrage) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:sendBarragebutton];
    
    _forbidBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(sendBarragebutton.EA_Left -10 -30, self.view.EA_Bottom - 20 - 30, 30,30)];
    [_forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off.png"] forState:UIControlStateNormal];
    [_forbidBarragebutton setBackgroundColor:[UIColor clearColor]];
    [_forbidBarragebutton addTarget:self action:@selector(forbidBarrage) forControlEvents:UIControlEventTouchUpInside];
    [myControlView addSubview:_forbidBarragebutton];
    
    _progressLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_progressLayer];
    
    CGPoint point = [_createVideobutton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:33.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth = 2;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    [self initBarrageData];
}



- (void)initBarrageData
{
    _dataArray = [NSMutableArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",nil];
    [self startBarrage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.barrageTextField resignFirstResponder];
    return YES;
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
                                               object:[self.avPlayer currentItem]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.avPlayerLayer.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    [self.view.layer addSublayer:self.avPlayerLayer];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    if (_isHold) {
        AVPlayerItem *p = [notification object];
        [p seekToTime:kCMTimeZero];
    }else
    {
        self.currentNum += 1;
        [self.avPlayer pause];
        [self kickbackProgressAnimation];
        [_progressLayer removeAllAnimations];
        [self.avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[self.mediaURLs objectAtIndex:_currentNum%7]]]];
        [self changeUserProfile];
    }
    
    [self.avPlayer play];
    [self startAnimation];
}

-(void)changeUserProfile
{
    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"好事青年小李", @"合作媒体微博",@"路人甲小白",@"文艺青年",@"我叫围观群众",@"小网红",@"业余记者晓龙",@"娱乐新星俊凯",@"直播大咖靖宇",@"职业记者一晶",@"自媒体人东寰",@"自拍达人老王",nil];
    [_userNameButton setTitle:[nameArray objectAtIndex:_currentNum%12] forState:UIControlStateNormal];
    [_userImagebutton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[nameArray objectAtIndex:_currentNum%12]]] forState:UIControlStateNormal];
}

- (void)holdVideo:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        _isHold = YES;
        
        _progressLayer.strokeColor = UIColorFromRGB(0xDCAC5B).CGColor;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _toastView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _toastView.image = [UIImage imageNamed:@"video_push_yellow.png"];
        [window addSubview:_toastView];
        [self showAnimation];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        _isHold = NO;
        [self hideAnimation:YES];
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    }else
    {
        
    }
}

- (void)fetchMediaUrl
{
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"mergeVideo.mov"];
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
    if (_isHold) {
        _progressLayer.strokeColor = UIColorFromRGB(0xDCAC5B).CGColor;
    }else
    {
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    
    
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
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _toastView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _toastView.image = [UIImage imageNamed:@"video_push_red.png"];
    [window addSubview:_toastView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation:) withObject:0 afterDelay:1];
}

-(void)showAnimation{
    _toastView.frame = CGRectMake(264,self.view.EA_Bottom - 55,2.44,0.49);
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _toastView.alpha = 1.0f;
    _toastView.frame = CGRectMake(20,self.view.EA_Bottom - 104,244,49);
    [UIView commitAnimations];
}

-(void)hideAnimation:(BOOL) immediately{
    if (immediately) {
        [_toastView removeFromSuperview];
    }else
    {
        [UIView beginAnimations:@"hide" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissToast)];
        [UIView setAnimationDuration:0.3];
        _toastView.alpha = 0.0f;
        [UIView commitAnimations];
    }
}

-(void)dismissToast
{
    [_toastView removeFromSuperview];
}

- (void)like
{
    if (_liked) {
        [_likebutton setImage:[UIImage imageNamed:@"video_like.png"] forState:UIControlStateNormal];
        _liked = NO;
    }else
    {
        [_likebutton setImage:[UIImage imageNamed:@"video_like_highlight.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            _likebutton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finish){
            [UIView animateWithDuration:0.3 animations:^{
                _likebutton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
        _liked = YES;
    }
    
}

-(void)sendBarrage
{
    
    [_dataArray insertObject:@"加的" atIndex:_curbarrageIndex + 1];
}

- (void)startBarrage {
    if (_dataArray && _dataArray.count > 0) {
        if (!_barragetimer) {
            _barragetimer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(postView) userInfo:nil repeats:YES];
        }
    }
}

- (void)stopBarrage {
    if (_barragetimer) {
        [_barragetimer invalidate];
        _barragetimer = nil;
    }
}

- (void)postView {
    if (_dataArray && _dataArray.count > 0) {
        int indexPath = random()%(int)((self.view.frame.size.height)/30);
        int top = indexPath * 30;
        
        UIView *view = [self.view viewWithTag:indexPath + ITEMTAG];
        if (view && [view isKindOfClass:[barrageItemView class]]) {
            return;
        }
        
        NSString *content = nil;
        if (_dataArray.count > _curbarrageIndex) {
            content = _dataArray[_curbarrageIndex];
            _curbarrageIndex++;
        } else {
            _curbarrageIndex = 0;
            content = _dataArray[_curbarrageIndex];
            _curbarrageIndex++;
        }
        
        for (barrageItemView *view in self.view.subviews) {
            if ([view isKindOfClass:[barrageItemView class]] && view.itemIndex == _curbarrageIndex-1) {
                return;
            }
        }
        
        barrageItemView *item = [[barrageItemView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, top, 10, 30)];
        
        [item setContent:content];
        
        item.itemIndex = _curbarrageIndex-1;
        item.tag = indexPath + ITEMTAG;
        [_allBarrageView addSubview:item];
        
        CGFloat speed = 85.;
        speed += random()%20;
        CGFloat time = (item.EA_Width+[[UIScreen mainScreen] bounds].size.width) / speed;
        
        [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut  animations:^{
            item.EA_Left = -item.EA_Width;
        } completion:^(BOOL finished) {
            [item removeFromSuperview];
        }];
        
    }
}

-(void)forbidBarrage
{
    if (_forbidenBarrage) {
        [_forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off.png"] forState:UIControlStateNormal];
        [_allBarrageView setHidden:NO];
        _forbidenBarrage = NO;
    }else
    {
        [_forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off_highlight.png"] forState:UIControlStateNormal];
        [_allBarrageView setHidden:YES];
        [UIView animateWithDuration:0.1 animations:^{
            _forbidBarragebutton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finish){
            [UIView animateWithDuration:0.3 animations:^{
                _forbidBarragebutton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
        _forbidenBarrage = YES;
    }
}

@end
