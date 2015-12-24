//
//  soundViewController.h
//  WeShow
//
//  Created by insomnia on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface soundViewController : UIViewController<AVAudioRecorderDelegate>
@property (strong, nonatomic) NSURL* mutedMediaUrl;
- (instancetype) initWithMediaUrl:(NSURL*)url;

@end
