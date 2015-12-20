//
//  psotViewController.h
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface postViewController : UIViewController

- (instancetype) initWithMediaUrl:(NSURL*)url;
- (instancetype) initWithComposition:(AVMutableComposition *)composition andVideoComposition:(AVMutableVideoComposition*)videoComposition;
@end
