//
//  DotView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "EABaseCardView.h"
#import "PulsingHaloLayer.h"

typedef void (^DotViewclickBlock)(void);

@interface DotView : EABaseCardView

@property (nonatomic,strong)DotViewclickBlock clickBlock;

@end
