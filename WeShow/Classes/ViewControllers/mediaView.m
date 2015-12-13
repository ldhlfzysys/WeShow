//
//  mediaView.m
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "mediaView.h"

@implementation mediaView

-(instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url isVideo:(BOOL)isvideo
{
    self = [super initWithFrame:frame];
    self.mediaUrl = url;
    self.isVideo = isvideo;
    if (isvideo) {
        [self initVideo];
    }else
    {
        [self initImage];
    }
    return self;
}

- (void)initVideo
{
    // the video player
    self.avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:self.mediaUrl]];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    //self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avPlayer currentItem]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.avPlayerLayer.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    [self.layer addSublayer:self.avPlayerLayer];
}

-(void)playerItemDidReachEnd:(NSNotification *)notification
{
    //playnext
}

- (void)initImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    UIImage* image = [UIImage imageNamed:@""];
    imageView.image = image;
    
    [self addSubview:imageView];
}
@end
