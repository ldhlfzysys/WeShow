//
//  DotView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "PulsingHaloLayer.h"

typedef void (^DotViewclickBlock)(void);

@interface DotView : UIView

@property (nonatomic,strong)DotViewclickBlock clickBlock;
@property (nonatomic,assign)CGFloat area;
- (void)loadAnimation:(CGFloat)area;

@end
