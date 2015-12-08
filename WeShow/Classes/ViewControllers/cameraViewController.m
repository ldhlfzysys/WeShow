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
#import "circleProgressView.h"

@interface cameraViewController ()<AVCaptureFileOutputRecordingDelegate>
@property (strong,nonatomic) AVCaptureMovieFileOutput *output;
@property (strong,nonatomic) CAShapeLayer *belowLayer;
@property (strong,nonatomic) CAShapeLayer *upLayer;
@property (strong,nonatomic) UIButton *capButton;
@property (assign,nonatomic) NSTimeInterval startTimestamp;
@property (assign,nonatomic) NSTimeInterval endTimestamp;

@end

@implementation cameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self videoInit];
    _capButton = [[UIButton alloc]initWithFrame:CGRectMake(120,667 - 195,55,55)];
    [_capButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [_capButton setBackgroundColor:[UIColor clearColor]];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoBtn:)];
    longPressGr.minimumPressDuration = 0;
    [_capButton addGestureRecognizer:longPressGr];
    
    [self.view addSubview:_capButton];
    
    _belowLayer = [[CAShapeLayer alloc] init];
    _upLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:_belowLayer];
    [self.view.layer addSublayer:_upLayer];
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
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    //7.将输入输出设备添加到会话中
    if ([session canAddInput:inputVideo]) {
        [session addInput:inputVideo];
    }
    if ([session canAddInput:inputAudio]) {
        [session addInput:inputAudio];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    //8.创建一个预览涂层
    AVCaptureVideoPreviewLayer *preLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    //设置图层的大小
    preLayer.frame = self.view.bounds;
    //添加到view上
    [self.view.layer addSublayer:preLayer];
    
    [session startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)startProgressAnimation
{
    CGPoint point = [_capButton center];
    UIBezierPath *belowpath = [UIBezierPath bezierPathWithArcCenter:point radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    _belowLayer.path = belowpath.CGPath;
    _belowLayer.fillColor = [UIColor clearColor].CGColor;
    _belowLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 4.0f;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0];
    [_belowLayer addAnimation:animation forKey:@"startAnimation"];
    
    UIBezierPath *uppath = [UIBezierPath bezierPathWithArcCenter:point radius:50 startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    _upLayer.path = uppath.CGPath;
    _upLayer.fillColor = [UIColor clearColor].CGColor;
    _upLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    [_upLayer addAnimation:animation forKey:@"startAnimation"];
}

- (void)kickbackProgressAnimation
{
    CFTimeInterval pausedTime = [_belowLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _belowLayer.timeOffset = pausedTime;
    _upLayer.timeOffset = pausedTime;
}

- (void)clickVideoBtn:(UILongPressGestureRecognizer *)gesture
{
    //判断是否在录制,如果在录制，就停止，并设置按钮title
//    if ([self.output isRecording]) {
//        [self.output stopRecording];
//        [sender setTitle:@"录制" forState:UIControlStateNormal];
//        return;
//    }
    
    //设置按钮的title
    //[sender setTitle:@"停止" forState:UIControlStateNormal];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        [self startProgressAnimation];
        NSDate* currentDate = [NSDate date];
        _startTimestamp = [currentDate timeIntervalSince1970];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSDate* currentDate = [NSDate date];
        _endTimestamp = [currentDate timeIntervalSince1970];
        if (_endTimestamp - _startTimestamp < 4) {
            NSLog(@"不足4秒");
            [self kickbackProgressAnimation];
            return;
        }
        NSLog(@"结束");
        [self.output stopRecording];
        //10.开始录制视频
        //设置录制视频保存的路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myVidio.mov"];
        
        //转为视频保存的url
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //开始录制,并设置控制器为录制的代理
        [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
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
    NSLog(@"完成录制,可以自己做进一步的处理");
}

@end
