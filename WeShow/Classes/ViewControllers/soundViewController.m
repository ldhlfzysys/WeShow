//
//  soundViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "soundViewController.h"
#import "postViewController.h"
#define progressRadius 30

@interface soundViewController ()
@property (strong, nonatomic) NSURL* mediaUrl;

@property (strong,nonatomic) CAShapeLayer *belowLayer;
@property (strong,nonatomic) CAShapeLayer *upLayer;
@property (strong,nonatomic) CAShapeLayer *leftLayer;
@property (strong,nonatomic) CAShapeLayer *rightLayer;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong,nonatomic) UIButton *capButton;

@property (strong,nonatomic) AVAudioRecorder *recorder;
@property (strong,nonatomic)NSURL *recordedTmpFile;
@property (strong,nonatomic)NSError *recordError;

@property (strong,nonatomic) NSTimer *showSecondAniTime;
@property (assign,nonatomic) BOOL videoEnoughTime;

@end

@implementation soundViewController

- (instancetype) initWithMediaUrl:(NSURL*)url
{
    if (self = [super init])
    {
        _mediaUrl = url;
    }
    
    return self;
}

- (void) initPlayer
{
    // the video player
    AVCaptureFileOutput *output = nil;
    self.avPlayer = [AVPlayer playerWithURL:self.mediaUrl];
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

- (void)initRecorder
{
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    //Setup the audioSession for playback and record.
    //We could just use record and then switch it to playback leter, but
    //since we are going to do both lets set it up once.
    
    NSError * error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
    //Activate the session
    [audioSession setActive:YES error: &error];
    self.recordError = error;
}

- (void)startRecord
{
    NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    //频率
    [recordSetting setValue:[NSNumber numberWithFloat:44110] forKey:AVSampleRateKey];
    //音量
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];

    _recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
    NSLog(@"Using File called: %@",_recordedTmpFile);
    //Setup the recorder to use this file and record to it.
    NSError *error = nil;
    _recorder = [[ AVAudioRecorder alloc] initWithURL:_recordedTmpFile settings:recordSetting error:&error];

    [_recorder setDelegate:self];
    [_recorder prepareToRecord];
    [_recorder record];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPlayer];
    
    // cancel button
    _capButton = [[UIButton alloc]initWithFrame:CGRectMake(120,667 - 195,55,55)];
    [_capButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [_capButton setBackgroundColor:[UIColor clearColor]];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoBtn:)];
    longPressGr.minimumPressDuration = 0;
    [_capButton addGestureRecognizer:longPressGr];
    [self.view addSubview:_capButton];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 55, 55)];
    [backbutton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    UIButton *postButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 40, 55, 55)];
    [postButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [postButton setBackgroundColor:[UIColor clearColor]];
    [postButton addTarget:self action:@selector(postFinalVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
    
    [self initAnimationLayer];
}

- (void) initAnimationLayer
{
    _belowLayer = [[CAShapeLayer alloc] init];
    _upLayer = [[CAShapeLayer alloc] init];
    _leftLayer = [[CAShapeLayer alloc] init];
    _rightLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_belowLayer];
    [self.view.layer addSublayer:_upLayer];
    [self.view.layer addSublayer:_leftLayer];
    [self.view.layer addSublayer:_rightLayer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.avPlayer play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)postFinalVideo
{

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

- (void) startCircleProgressAnimation
{
    CGPoint point = [_capButton center];
    [self startCircleProgressAnimation:_belowLayer startAngle:0 endAngle:M_PI duration:4.0f];
    [self startCircleProgressAnimation:_upLayer startAngle:M_PI endAngle:2*M_PI duration:4.0f];
    [self startLineProgressAnimation:_leftLayer startPoint:CGPointMake(point.x - progressRadius, point.y) endPoint:CGPointMake(10, point.y) duration:4.0f];
    [self startLineProgressAnimation:_rightLayer startPoint:CGPointMake(point.x + progressRadius, point.y) endPoint:CGPointMake(310, point.y) duration:4.0f];
}
- (void)startCircleProgressAnimation:(CAShapeLayer *)layer startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle duration:(CFTimeInterval) time
{
    CGPoint point = [_capButton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.lineWidth = 4;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = time;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0];
    
    [layer addAnimation:animation forKey:@"CircleAnimation"];
}

- (void)startLineProgressAnimation:(CAShapeLayer *)layer startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint duration:(CFTimeInterval) time
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    path.lineWidth = 4;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = time;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    
    [layer addAnimation:animation forKey:@"LineAnimation"];
}

- (void) videoIsLongEnough
{
    _videoEnoughTime = YES;
}

- (void)kickbackCircleProgressAnimation
{
    CFTimeInterval pausedTime = [_belowLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _belowLayer.timeOffset = pausedTime;
    _upLayer.timeOffset = pausedTime;
}

- (void)pauseCircleProgressAnimation
{
    CFTimeInterval pausedTime = [_belowLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _belowLayer.speed = 0.0f;
    _upLayer.speed = 0.0f;
    _leftLayer.speed = 0.0f;
    _rightLayer.speed = 0.0f;
    _belowLayer.timeOffset = pausedTime;
    _upLayer.timeOffset = pausedTime;
    _leftLayer.timeOffset = pausedTime;
    _rightLayer.timeOffset = pausedTime;
}

- (void)clickVideoBtn:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        [self startCircleProgressAnimation];
        [[self.avPlayer currentItem] seekToTime:kCMTimeZero];
        [self startRecord];
        _showSecondAniTime = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(videoIsLongEnough) userInfo:nil repeats:NO];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (!_videoEnoughTime) {
            NSLog(@"不足4秒");
            [_showSecondAniTime invalidate];
            [self kickbackCircleProgressAnimation];
            
            NSFileManager * fm = [NSFileManager defaultManager];
            NSError *error = nil;
            [fm removeItemAtPath:[_recordedTmpFile path] error:&error];
            return;
        }
        //停止动画
        [self pauseCircleProgressAnimation];
        [_capButton setEnabled:NO];
        [_recorder stop];
        postViewController *VC = [[postViewController alloc]initWithMediaUrl:_mediaUrl];
        [self presentViewController:VC animated:YES completion:^{
            
        }];
        
        NSLog(@"结束");
        
    }else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        
    }else
    {
        NSLog(@"意外");
    }
}

@end
