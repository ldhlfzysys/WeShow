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
//弹幕视图
@implementation BarrageView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (result == self) {
        return nil;
    }
    return result;
}

@end

@implementation VedioControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //self.backgroundColor = [UIColor grayColor];
        _backbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + STATUSBAR.size.height, 25,25)];
        [_backbutton setImage:[UIImage imageNamed:@"video_back.png"] forState:UIControlStateNormal];
        [_backbutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_backbutton];
        
        _userImagebutton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.EA_Bottom - 20 - 30, 30,30)];
        [_userImagebutton setImage:[UIImage imageNamed:@"video_profile.png"] forState:UIControlStateNormal];
        [_userImagebutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_userImagebutton];
        
        _userNameButton = [[UIButton alloc]initWithFrame:CGRectMake(20 + 30 + 7, self.EA_Bottom - 20 - 30, 80,30)];
        [_userNameButton setTitle:@"Jean Hanson" forState:UIControlStateNormal];
        [_userNameButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_userNameButton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_userNameButton];
        
        _createVideobutton = [[UIButton alloc]initWithFrame:CGRectMake(self.EA_Right - 24 - 62, self.EA_Bottom - 24 - 62, 62,62)];
        [_createVideobutton setImage:[UIImage imageNamed:@"video_create.png"] forState:UIControlStateNormal];
        [_createVideobutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_createVideobutton];
        
        _skipbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.EA_Right - 20 - 40, _createVideobutton.EA_Top - 18 - 40, 40,40)];
        [_skipbutton setImage:[UIImage imageNamed:@"video_next.png"] forState:UIControlStateNormal];
        [_skipbutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_skipbutton];
        
        _likebutton = [[UIButton alloc]initWithFrame:CGRectMake(_createVideobutton.EA_Left - 19 -30, self.EA_Bottom - 20 - 30, 30,30)];
        [_likebutton setImage:[UIImage imageNamed:@"video_like.png"] forState:UIControlStateNormal];
        [_likebutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_likebutton];
        
        _sendBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(_likebutton.EA_Left -10 -30, self.EA_Bottom - 20 - 30, 30,30)];
        [_sendBarragebutton setImage:[UIImage imageNamed:@"video_barrage.png"] forState:UIControlStateNormal];
        [_sendBarragebutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_sendBarragebutton];
        
        _forbidBarragebutton = [[UIButton alloc]initWithFrame:CGRectMake(_sendBarragebutton.EA_Left -10 -30, self.EA_Bottom - 20 - 30, 30,30)];
        [_forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off.png"] forState:UIControlStateNormal];
        [_forbidBarragebutton setBackgroundColor:[UIColor clearColor]];

        [self addSubview:_forbidBarragebutton];
        
        _commentView = [[CommentPostView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 50)];
        _commentView.EA_Top = self.EA_Bottom;
        [self addSubview:_commentView];
    }
    return self;
}

@end

@interface sceneViewController()
@property (strong,nonatomic) NSArray *mediaURLs;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (assign, nonatomic) BOOL isHold;

@property (strong,nonatomic) CAShapeLayer *progressLayer;

@property (strong,nonatomic) UIImageView *toastView;
@property (assign, nonatomic) BOOL liked;
@property (assign, nonatomic) BOOL forbidenBarrage;


@property (assign ,nonatomic) NSInteger currentNum;


@property (strong,nonatomic) NSTimer *barragetimer;
@property (assign, nonatomic) NSInteger curbarrageIndex;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation sceneViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    _isHold = NO;
    // the video player
    [self fetchMediaUrl];
    
    self.currentNum = 0;
    [self initVideoPlayer];
    
    _controlView = [[VedioControlView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_controlView];
    _controlView.commentView.commentFiled.delegate = self;
    [_controlView.backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.userImagebutton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.userNameButton addTarget:self action:@selector(userProfile) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.createVideobutton addTarget:self action:@selector(createVideo) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.skipbutton addTarget:self action:@selector(playerItemDidReachEnd:) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.likebutton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.sendBarragebutton addTarget:self action:@selector(sendBarrage) forControlEvents:UIControlEventTouchUpInside];
    [_controlView.forbidBarragebutton addTarget:self action:@selector(forbidBarrage) forControlEvents:UIControlEventTouchUpInside];
    
    __block sceneViewController *blockSelf = self;
    [_controlView.commentView setPostBtnBlock:^{
        [blockSelf addItem:blockSelf.controlView.commentView.commentFiled.text Highlight:YES];
        [blockSelf.controlView.commentView.commentFiled resignFirstResponder];
    }];
    
    _barrageView = [[BarrageView alloc]initWithFrame:CGRectMake(0, STATUSBAR.size.height + 40, self.view.EA_Width, 400)];
    _barrageView.layer.masksToBounds = YES;
    [_controlView addSubview:_barrageView];
    

    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdVideo:)];
    longPressGr.minimumPressDuration = 0.2;
    
    [_controlView addGestureRecognizer:longPressGr];
    
    
    
    _progressLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_progressLayer];
    
    CGPoint point = [_controlView.createVideobutton center];
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
    [_dataArray insertObject:_controlView.commentView.commentFiled.text atIndex:_curbarrageIndex + 1];
    [_controlView.commentView.commentFiled resignFirstResponder];
    [_controlView.commentView.commentFiled setHidden:YES];
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
        [_progressLayer removeAllAnimations];
        AVPlayer *newPlayer = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[self.mediaURLs objectAtIndex:_currentNum%26]]]];
        _avPlayer = newPlayer;
        self.avPlayerLayer.player = _avPlayer;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[_avPlayer currentItem]];
    }
    
    [_avPlayer play];
    [self startAnimation];
}

-(void)changeUserProfile
{
    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"好事青年小李", @"合作媒体微博",@"路人甲小白",@"文艺青年",@"我叫围观群众",@"小网红",@"业余记者晓龙",@"娱乐新星俊凯",@"直播大咖靖宇",@"职业记者一晶",@"自媒体人东寰",@"自拍达人老王",nil];
    [_controlView.userNameButton setTitle:[nameArray objectAtIndex:_currentNum%12] forState:UIControlStateNormal];
    [_controlView.userImagebutton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[nameArray objectAtIndex:_currentNum%12]]] forState:UIControlStateNormal];
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
    NSString *path2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"001.mp4"];
    NSString *path3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"002.mp4"];
    NSString *path4 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"003.mp4"];
    NSString *path5 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"004.mp4"];
    NSString *path6 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"005.mp4"];
    NSString *path7 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"006.mp4"];
    NSString *path8 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"007.mp4"];
    NSString *path9 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"008.mp4"];
    NSString *path10 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"009.mp4"];
    NSString *path11 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"010.mp4"];
    NSString *path12= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"011.mp4"];
    NSString *path13= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"012.mp4"];
    NSString *path14= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"013.mp4"];
    NSString *path15= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q14.mp4"];
    NSString *path16= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q15.mp4"];
    NSString *path17= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q16.mp4"];
    NSString *path18= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q17.mp4"];
    NSString *path19= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q18.mp4"];
    NSString *path20= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q19.mp4"];
    NSString *path21= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q20.mp4"];
    NSString *path22= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q21.mp4"];
    NSString *path23= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q22.mp4"];
    NSString *path24= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q23.mp4"];
    NSString *path25= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q24.mp4"];
    NSString *path26= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"q25.mp4"];
    
    self.mediaURLs = [NSArray arrayWithObjects:path1, path2,path3,path4,path5,path6,path7,path8,path9,path10,path11,path12,path13,path14,path15,path16,path17,path18,path19,path20,path21,path22,path23,path24,path25,path26,nil];
}

- (void) startAnimation
{
    CGPoint point = [_controlView.createVideobutton center];
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
        [_controlView.likebutton setImage:[UIImage imageNamed:@"video_like.png"] forState:UIControlStateNormal];
        _liked = NO;
    }else
    {
        [_controlView.likebutton setImage:[UIImage imageNamed:@"video_like_highlight.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            _controlView.likebutton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finish){
            [UIView animateWithDuration:0.3 animations:^{
                _controlView.likebutton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
        _liked = YES;
    }
    
}

-(void)sendBarrage
{
    [_controlView.commentView.commentFiled becomeFirstResponder];
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
        
        [self addItem:content Highlight:NO];
        
    }
}

- (void)addItem:(NSString *)content Highlight:(BOOL)highlight{
    int indexPath = random()%(int)((self.view.frame.size.height)/30);
    int top = indexPath * 30;
    barrageItemView *item = [[barrageItemView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width, MIN(top, _barrageView.EA_Height - 30) , 10, 30)];
    if (highlight) {
        item.contentLabel.textColor = [UIColor redColor];
    }
    else{
        item.contentLabel.textColor = [UIColor whiteColor];
    }
    [item setContent:content];
    
    item.itemIndex = _curbarrageIndex-1;
    item.tag = indexPath + ITEMTAG;
    [_barrageView addSubview:item];
    
    CGFloat speed = 85.;
    speed += random()%20;
    CGFloat time = (item.EA_Width+[[UIScreen mainScreen] bounds].size.width) / speed;
    
    [UIView animateWithDuration:time delay:0.f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut  animations:^{
        item.EA_Left = -item.EA_Width;
    } completion:^(BOOL finished) {
        [item removeFromSuperview];
    }];
}

-(void)forbidBarrage
{
    if (_forbidenBarrage) {
        [_controlView.forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off.png"] forState:UIControlStateNormal];
        [_barrageView setHidden:NO];
        _forbidenBarrage = NO;
    }else
    {
        [_controlView.forbidBarragebutton setImage:[UIImage imageNamed:@"video_barrage_off_highlight.png"] forState:UIControlStateNormal];
        [_barrageView setHidden:YES];
        [UIView animateWithDuration:0.1 animations:^{
            _controlView.forbidBarragebutton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finish){
            [UIView animateWithDuration:0.3 animations:^{
                _controlView.forbidBarragebutton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
        _forbidenBarrage = YES;
    }
}

- (void)keyBoardShow:(NSNotification *)noti{
    NSDictionary *info = [noti userInfo];
    
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    _controlView.commentView.EA_Bottom = _controlView.EA_Height + yOffset;
    
}

- (void)keyBoardHide:(NSNotification *)noti{
    _controlView.commentView.EA_Top = _controlView.EA_Bottom;
}

@end
