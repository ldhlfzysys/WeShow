//
//  CreateViewController.h
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "IncidentView.h"
#import "PullView.h"
#import "sceneViewController.h"
@interface CreateViewController : UIViewController<PullViewDelegate,IncidentViewDelegate>
@property (nonatomic,strong)PullView *bottomView;
@end
