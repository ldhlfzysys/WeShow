//
//  MainViewController.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EABaseViewController.h"
#import "PullView.h"
#import "IncidentView.h"

@interface MainViewController : EABaseViewController<PullViewDelegate,UIScrollViewDelegate,IncidentViewDelegate>

@end
