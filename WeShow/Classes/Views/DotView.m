//
//  DotView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "DotView.h"

@implementation DotView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *bc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, self.EA_Height)];
        bc.image = [UIImage imageNamed:@"map_range"];
        [self addSubview:bc];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClick)];
        [self addGestureRecognizer:tapGes];
        
        UIImageView *testDotTag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 21)];
        testDotTag.image = [UIImage imageNamed:@"map_live"];
        testDotTag.EA_CenterX = bc.frame.size.width/2;
        testDotTag.EA_Bottom = bc.frame.size.height/2;
        [self addSubview:testDotTag];
        
        PulsingHaloLayer *testLayer1 = [[PulsingHaloLayer alloc]init];
        testLayer1.position = CGPointMake(self.EA_Width/2, self.EA_Width/2);
        testLayer1.radius = 40;
        testLayer1.animationDuration = 1.5;
        testLayer1.pulseInterval = 1.5;
        [self.layer addSublayer:testLayer1];
        
        PulsingHaloLayer *testLayer2 = [[PulsingHaloLayer alloc]init];
        testLayer2.position = CGPointMake(self.EA_Width/2, self.EA_Width/2);
        testLayer2.radius = 70;
        testLayer2.animationDuration = 3;
        testLayer2.pulseInterval = 0;
        [self.layer addSublayer:testLayer2];
        
        

    }
    return self;
}

- (void)didClick{
    self.clickBlock();
}
@end
