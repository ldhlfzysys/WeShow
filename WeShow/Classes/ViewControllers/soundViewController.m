//
//  soundViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "soundViewController.h"
#import "postViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "sceneViewController.h"
#define progressRadius 43

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
@property (assign,nonatomic) float itemDuration;

@property (strong,nonatomic) NSTimer *showSecondAniTime;
@property (assign,nonatomic) BOOL videoEnoughTime;

@end

@implementation soundViewController

- (instancetype) initWithMediaUrl:(NSURL*)url
{
    if (self = [super init])
    {
        _mediaUrl = url;
        _itemDuration = CMTimeGetSeconds([AVAsset assetWithURL:_mediaUrl].duration);
    }
    
    return self;
}

- (void) initPlayer
{
    // the video player
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
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initPlayer];
    
    // cancel button
    _capButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_CenterX - 40,self.view.EA_Bottom - 110,80,80)];
    [_capButton setImage:[UIImage imageNamed:@"photo_sound.png"] forState:UIControlStateNormal];
    [_capButton setBackgroundColor:[UIColor clearColor]];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoBtn:)];
    longPressGr.minimumPressDuration = 0;
    [_capButton addGestureRecognizer:longPressGr];
    [self.view addSubview:_capButton];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + STATUSBAR.size.height, 25,25)];
    [backbutton setImage:[UIImage imageNamed:@"video_back.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    UIButton *postButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_Right - 15 - 25, 15 + STATUSBAR.size.height, 25,25)];
    [postButton setImage:[UIImage imageNamed:@"photo_send.png"] forState:UIControlStateNormal];
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
    
    CGPoint point = [_capButton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:0 endAngle:M_PI clockwise:YES];
    _belowLayer.path = path.CGPath;
    _belowLayer.lineWidth = 3;
    _belowLayer.fillColor = [UIColor clearColor].CGColor;
    _belowLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    _upLayer.path = path1.CGPath;
    _upLayer.lineWidth = 3;
    _upLayer.fillColor = [UIColor clearColor].CGColor;
    _upLayer.strokeColor = [UIColor whiteColor].CGColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.avPlayer play];
    [self startCircleProgressAnimation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.avPlayer pause];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    [self startCircleProgressAnimation];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)postFinalVideo
{
    sceneViewController *VC = [[sceneViewController alloc]init];
    [self presentViewController:VC animated:NO completion:^{}];
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
    [self startCircleProgressAnimation:_belowLayer startAngle:0 endAngle:M_PI duration:_itemDuration];
    [self startCircleProgressAnimation:_upLayer startAngle:M_PI endAngle:2*M_PI duration:_itemDuration];
    [self startLineProgressAnimation:_leftLayer startPoint:CGPointMake(point.x - progressRadius + 1.5, point.y) endPoint:CGPointMake(10, point.y) duration:_itemDuration];
    [self startLineProgressAnimation:_rightLayer startPoint:CGPointMake(point.x + progressRadius - 1.5, point.y) endPoint:CGPointMake(365, point.y) duration:_itemDuration];
}
- (void)startCircleProgressAnimation:(CAShapeLayer *)layer startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle duration:(CFTimeInterval) time
{
    CGPoint point = [_capButton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 3;
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
    layer.path = path.CGPath;
    layer.lineWidth = 3;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = time;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.fillMode = kCAFillModeBackwards;
    
    [layer addAnimation:animation forKey:@"LineAnimation"];
    //    _animationTest = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //        _animationTest.duration = time;
    //        _animationTest.fromValue = [NSNumber numberWithFloat:0];
    //        _animationTest.toValue = [NSNumber numberWithFloat:1.0];
    //    _animationTest.fillMode = kCAFillModeBackwards;
    //
    //    [layer addAnimation:_animationTest forKey:@"LineAnimation"];
}

- (void) videoIsLongEnough
{
    _videoEnoughTime = YES;
}

- (void)kickbackProgressAnimation
{
    CFTimeInterval pausedTime = [_belowLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _belowLayer.timeOffset = pausedTime;
    _upLayer.timeOffset = pausedTime;
    _rightLayer.timeOffset = _rightLayer.beginTime + 6 - pausedTime;
    _leftLayer.timeOffset = _rightLayer.beginTime + 6 - pausedTime;
}

- (void)pauseProgressAnimation
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
        //[self.avPlayer pause];
        //[self.avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:self.mutedMediaUrl]];
        [self startRecord];
        _showSecondAniTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(videoIsLongEnough) userInfo:nil repeats:NO];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.avPlayer setMuted:NO];
        if (!_videoEnoughTime) {
            NSLog(@"不足1秒");
            [_showSecondAniTime invalidate];
            [self kickbackProgressAnimation];
            //[self.avPlayer pause];
            //[self.avPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:self.mediaUrl]];
            NSFileManager * fm = [NSFileManager defaultManager];
            NSError *error = nil;
            [fm removeItemAtPath:[_recordedTmpFile path] error:&error];
            return;
        }
        //停止动画
        [self pauseProgressAnimation];
        [_capButton setEnabled:NO];
        [_recorder stop];

        
        NSLog(@"结束");
        
    }else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        
    }else
    {
        NSLog(@"意外");
    }
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        
        AVAsset* originAsset = [AVAsset assetWithURL:self.mediaUrl];
        
        AVAsset* personAudioAsset = [AVAsset assetWithURL:_recordedTmpFile];
        
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, originAsset.duration)
                            ofTrack:[[originAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        
        CGAffineTransform t1;
        CGAffineTransform t2;
        
        t1 = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
        // Rotate transformation
        t2 = CGAffineTransformRotate(t1, 0.5 * M_PI);
        [videoTrack setPreferredTransform:t2];
        
        
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, personAudioAsset.duration)
                            ofTrack:[[personAudioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        
        double offset = CMTimeGetSeconds(originAsset.duration) - CMTimeGetSeconds(personAudioAsset.duration);
        
        [audioTrack insertTimeRange:CMTimeRangeMake(personAudioAsset.duration, CMTimeMakeWithSeconds(offset, 44100))
                            ofTrack:[[originAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:personAudioAsset.duration error:nil];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"mergeVideo.mov"]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetHighestQuality];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:myPathDocs])
        {
            [[NSFileManager defaultManager] removeItemAtPath:myPathDocs error:nil];
        }
        exporter.outputURL = url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        exporter.shouldOptimizeForNetworkUse = YES;
        
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            if (exporter.status == AVAssetExportSessionStatusCompleted) {
                NSLog(@"拼接outputURL:%@",exporter.outputURL);
                
                postViewController *VC = [[postViewController alloc]initWithMediaUrl:exporter.outputURL];
                [self presentViewController:VC animated:NO completion:^{}];

            }else if (exporter.status == AVAssetExportSessionStatusFailed)
            {
                NSLog(@"拼接失败,error is %@",exporter.error);
            }
        }];
        

    }else
    {
        NSLog(@"录音失败");
    }

}
@end
