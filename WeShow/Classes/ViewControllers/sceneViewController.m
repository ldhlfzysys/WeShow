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

@property (assign ,nonatomic) NSInteger currentNum;


@end

@implementation sceneViewController

- (void)viewDidLoad
{
    // the video player
    [self fetchMediaUrl];
    
    self.currentNum = 0;
    
    //self.avPlayer = [AVPlayer playerWithURL:self.mediaURL];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.avPlayer play];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification
{
//    self.currentNum += 1;
//    self.avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:[self.mediaURLs objectAtIndex:_currentNum]]];
//    [self.avPlayer play];
}

- (void)fetchMediaUrl
{
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo.mov"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path1]) {
        NSLog(@"存在,%@",path1);
    }
    
    NSString *path2 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo45.mov"];
    NSString *path3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo46.mov"];
    NSString *path4 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo50.mov"];
    NSString *path5 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo52.mov"];
    NSString *path6 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo72.mov"];
    NSString *path7 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myVideo79.mov"];
    
    self.mediaURLs = [NSArray arrayWithObjects:path1, path2,path3,path4,path5,path6,path7,@"8",@"9",@"10",nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
