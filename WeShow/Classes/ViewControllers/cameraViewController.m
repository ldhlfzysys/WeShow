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
@property (strong,nonatomic) circleProgressView *progress;
@property (assign,nonatomic) NSTimeInterval startTimestamp;
@property (assign,nonatomic) NSTimeInterval endTimestamp;
@end

@implementation cameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self videoInit];
    UIButton *capButton = [[UIButton alloc]initWithFrame:CGRectMake(120,667 - 195,55,55)];
    [capButton setImage:[UIImage imageNamed:@"map_create.png"] forState:UIControlStateNormal];
    [capButton setBackgroundColor:[UIColor clearColor]];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoBtn:)];
    longPressGr.minimumPressDuration = 0;
    [capButton addGestureRecognizer:longPressGr];
    
    [self.view addSubview:capButton];
    
    _progress = [[circleProgressView alloc]initWithFrame:CGRectMake(120, 667 - 295, 60, 60)];
    _progress.arcFinishColor = [UIColor whiteColor];
    _progress.centerColor = [UIColor clearColor];
    _progress.arcUnfinishColor = [UIColor redColor];
    _progress.arcBackColor = [UIColor clearColor];
    _progress.percent = 1;
    [self.view addSubview:_progress];
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
        NSDate* currentDate = [NSDate date];
        _startTimestamp = [currentDate timeIntervalSince1970];
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSDate* currentDate = [NSDate date];
        _endTimestamp = [currentDate timeIntervalSince1970];
        if (_endTimestamp - _startTimestamp < 4) {
            NSLog(@"不足4秒");

            //回弹动画
            return;
        }
        NSLog(@"结束");
        //10.开始录制视频
        //设置录制视频保存的路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"myVidio.mov"];
        
        //转为视频保存的url
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //开始录制,并设置控制器为录制的代理
        [self.output startRecordingToOutputFileURL:url recordingDelegate:self];
    }else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        //进度条处理
        NSDate* currentDate = [NSDate date];
        NSTimeInterval currentTime = [currentDate timeIntervalSince1970];
        [_progress setPercent:(currentTime - _startTimestamp)/8];
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
