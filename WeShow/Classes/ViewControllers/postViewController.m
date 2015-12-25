//
//  psotViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "postViewController.h"
#import "sceneViewController.h"

@interface postViewController()
@property (strong, nonatomic) NSURL* mediaUrl;
@property (strong, nonatomic) UIImage *postImage;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong,nonatomic) UIButton *capButton;

@property (strong, nonatomic) AVMutableComposition *composition;
@property (strong, nonatomic) AVMutableVideoComposition *videoComposition;

@end
@implementation postViewController

- (instancetype) initWithMediaUrl:(NSURL*)url
{
    if (self = [super init])
    {
        _mediaUrl = url;
    }
    
    return self;
}

- (instancetype) initWithImage:(UIImage*)image
{
    if (self = [super init])
    {
        _postImage = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _capButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.EA_CenterX - 40,self.view.EA_Bottom - 110,80,80)];
    [_capButton setImage:[UIImage imageNamed:@"photo_send_big.png"] forState:UIControlStateNormal];
    [_capButton setBackgroundColor:[UIColor clearColor]];
    [_capButton addTarget:self action:@selector(postFinalVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_capButton];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + STATUSBAR.size.height, 25,25)];
    [backbutton setImage:[UIImage imageNamed:@"video_back.png"] forState:UIControlStateNormal];
    [backbutton setBackgroundColor:[UIColor clearColor]];
    [backbutton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    // the video player
    if (!self.mediaUrl) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        imageView.image = self.postImage;
        [self.view addSubview:imageView];
    }else
    {
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.avPlayer currentItem]) {
        [self.avPlayer play];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.avPlayer currentItem]) {
        [self.avPlayer pause];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
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

@end
