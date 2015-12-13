//
//  mediaView.h
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface mediaView : UIView

-(instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url isVideo:(BOOL)isvideo;

@property(assign,nonatomic)   BOOL isVideo;
@property(strong,nonatomic)   NSString *mediaUrl;

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;

@end
