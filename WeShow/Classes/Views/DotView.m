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
        
//        UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, self.EA_Width)];
//        bg.backgroundColor = UIColorFromRGB(0x2285df);
//        bg.alpha = 0.2;
//        bg.layer.masksToBounds = YES;
//        bg.layer.cornerRadius = self.EA_Width/2;
//        bg.EA_CenterX = bc.frame.size.width/2;
//        bg.EA_CenterY = bc.frame.size.height/2;
//        [self addSubview:bg];
        
        CGFloat scaleValue = self.EA_Width / 130.0;
        
        PulsingHaloLayer *testLayer1 = [[PulsingHaloLayer alloc]initWithAlphas:@[@0.9, @0.9, @0]];
        testLayer1.backgroundColor = UIColorFromRGB(0x2285df).CGColor;
        testLayer1.position = CGPointMake(self.EA_Width/2, self.EA_Width/2);
        testLayer1.radius = 20 * scaleValue;
        testLayer1.animationDuration = 3;
        testLayer1.pulseInterval = 0;
        [self.layer addSublayer:testLayer1];
        
        PulsingHaloLayer *testLayer2 = [[PulsingHaloLayer alloc]initWithAlphas:@[@0.7, @0.7, @0]];
        testLayer2.backgroundColor = UIColorFromRGB(0x2285df).CGColor;
        testLayer2.position = CGPointMake(self.EA_Width/2, self.EA_Width/2);
        testLayer2.radius = 40 * scaleValue;
        testLayer2.animationDuration = 3;
        testLayer2.pulseInterval = 0;
        [self.layer addSublayer:testLayer2];
        
        PulsingHaloLayer *testLayer3 = [[PulsingHaloLayer alloc]initWithAlphas:@[@0.45, @0.45, @0]];
        testLayer3.position = CGPointMake(self.EA_Width/2, self.EA_Width/2);
        testLayer3.radius = 60 * scaleValue;
        testLayer3.animationDuration = 3;
        testLayer3.pulseInterval = 0;
        [self.layer addSublayer:testLayer3];
        
        

    }
    return self;
}

- (void)didClick{
    self.clickBlock();
}
@end
