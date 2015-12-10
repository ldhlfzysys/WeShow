//
//  cameraViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/8.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "cameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "soundViewController.h"

#define progressRadius 30

@interface cameraViewController ()<AVCaptureFileOutputRecordingDelegate>
@property (strong,nonatomic) AVCaptureMovieFileOutput *output;

@property (strong,nonatomic) CAShapeLayer *belowLayer;
@property (strong,nonatomic) CAShapeLayer *upLayer;
@property (strong,nonatomic) CAShapeLayer *leftLayer;
@property (strong,nonatomic) CAShapeLayer *rightLayer;

@property (strong,nonatomic) UIButton *capButton;
@property (strong,nonatomic) NSTimer *showSecondAniTime;
@property (assign,nonatomic) BOOL videoEnoughTime;
@property (strong,nonatomic) AVCaptureSession *session;

@property (strong,nonatomic) CABasicAnimation *animationTest;

@end

@implementation cameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self videoInit];
    _capButton = [[UIButton alloc]initWithFrame:CGRectMake(135,667 - 195,50,50)];
    [_capButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [_capButton setBackgroundColor:[UIColor clearColor]];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoBtn:)];
    longPressGr.minimumPressDuration = 0;
    [_capButton addGestureRecognizer:longPressGr];
    [self.view addSubview:_capButton];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(40, 40, 50,50)];
    [backbutton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    UIButton *turnAroundButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 40, 50,50)];
    [turnAroundButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [turnAroundButton setBackgroundColor:[UIColor clearColor]];
    [turnAroundButton addTarget:self action:@selector(turnAround) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:turnAroundButton];
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
    _belowLayer.lineWidth = 2;
    _belowLayer.fillColor = [UIColor clearColor].CGColor;
    _belowLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    _upLayer.path = path1.CGPath;
    _upLayer.lineWidth = 2;
    _upLayer.fillColor = [UIColor clearColor].CGColor;
    _upLayer.strokeColor = [UIColor whiteColor].CGColor;
}

- (void)videoInit
{
    //1.创建视频设备(摄像头前，后)
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    //2.初始化一个摄像头输入设备(first是后置摄像头，last是前置摄像头)
    AVCaptureDeviceInput *inputVideo = [AVCaptureDeviceInput deviceInputWithDevice:[devices firstObject] error:NULL];
    
    //3.创建麦克风设备
    AVCaptureDevice *deviceAudio = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    //4.初始化麦克风输入设备
    AVCaptureDeviceInput *inputAudio = [AVCaptureDeviceInput deviceInputWithDevice:deviceAudio error:NULL];
    
    AVCaptureMovieFileOutput *output = [[AVCaptureMovieFileOutput alloc] init];
    self.output = output; //保存output，方便下面操作
    
    //6.初始化一个会话
    _session = [[AVCaptureSession alloc] init];
    
    //7.将输入输出设备添加到会话中
    if ([_session canAddInput:inputVideo]) {
        [_session addInput:inputVideo];
    }
    if ([_session canAddInput:inputAudio]) {
        [_session addInput:inputAudio];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    
    //8.创建一个预览涂层
    AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    //设置图层的大小
    preLayer.frame = self.view.bounds;
    //添加到view上
    [self.view.layer addSublayer:preLayer];
    
    [_session startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_capButton setEnabled:YES];
    [self initAnimationLayer];
    _videoEnoughTime = NO;
    //[self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

- (void)turnAround
{
    NSArray *inputs = self.session.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.session beginConfiguration];
            
            [self.session removeInput:input];
            [self.session addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.session commitConfiguration];
            break;
        }
    }
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
    [self startCircleProgressAnimation:_belowLayer startAngle:0 endAngle:M_PI duration:8.0f];
    [self startCircleProgressAnimation:_upLayer startAngle:M_PI endAngle:2*M_PI duration:8.0f];
    [self startLineProgressAnimation:_leftLayer startPoint:CGPointMake(point.x - progressRadius, point.y) endPoint:CGPointMake(10, point.y) duration:8.0f];
    [self startLineProgressAnimation:_rightLayer startPoint:CGPointMake(point.x + progressRadius, point.y) endPoint:CGPointMake(310, point.y) duration:8.0f];
}
- (void)startCircleProgressAnimation:(CAShapeLayer *)layer startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle duration:(CFTimeInterval) time
{
    CGPoint point = [_capButton center];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:progressRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    layer.path = path.CGPath;
    layer.lineWidth = 2;
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
    layer.lineWidth = 2;
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
    _rightLayer.timeOffset = _rightLayer.beginTime + 4 - pausedTime;
    _leftLayer.timeOffset = _rightLayer.beginTime + 4 - pausedTime;
//    NSNumber *num = [_rightLayer.presentationLayer valueForKey:@"strokeEnd"];
//    
//    [_rightLayer removeAnimationForKey:@"LineAnimation"];
//    _animationTest.duration = 0.3f;
//    _animationTest.fromValue = num;
//    _animationTest.toValue = [NSNumber numberWithFloat:0.0];
//    _animationTest.fillMode = kCAFillModeBoth;
//    [_rightLayer addAnimation:_animationTest forKey:@"layerAnimation_reverse"];
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
    //设置录制视频保存的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myVidio.mov"];
    
    //转为视频保存的url
    NSURL *url = [NSURL fileURLWithPath:path];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        //开始录制,并设置控制器为录制的代理
        [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
        [self startCircleProgressAnimation];
        _showSecondAniTime = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(videoIsLongEnough) userInfo:nil repeats:NO];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.output stopRecording];
        if (!_videoEnoughTime) {
            NSLog(@"不足4秒");
            [_showSecondAniTime invalidate];
            [self kickbackProgressAnimation];
            return;
        }
        //停止动画
        [self pauseProgressAnimation];
        [_capButton setEnabled:NO];

        NSLog(@"结束");
        
    }else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        
    }else
    {
        NSLog(@"意外");
    }
}

#pragma  mark - AVCaptureFileOutputRecordingDelegate
//录制完成代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    if (_videoEnoughTime) {
        NSLog(@"完成录制,可以自己做进一步的处理");
        soundViewController *VC = [[soundViewController alloc]initWithMediaUrl:outputFileURL];
        [self presentViewController:VC animated:YES completion:^{
            [_belowLayer removeFromSuperlayer];
            [_upLayer removeFromSuperlayer];
            [_leftLayer removeFromSuperlayer];
            [_rightLayer removeFromSuperlayer];
        }];
    }
}

@end
