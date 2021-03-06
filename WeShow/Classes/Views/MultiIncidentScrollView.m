//
//  MultiIncidentScrollView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "MultiIncidentScrollView.h"

@implementation MultiIncidentScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, self.EA_Height - 20)];
        _mainScroll.contentSize = CGSizeMake(618, _mainScroll.EA_Height);
        _mainScroll.showsVerticalScrollIndicator = NO;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_mainScroll];
        
        CGFloat baseX = 0;
        for (int i = 0; i < 6; i++) {
            UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(baseX, 0, 100, _mainScroll.EA_Height)];
            image1.backgroundColor = [UIColor grayColor];
            [_mainScroll addSubview:image1];
            
            UIImageView *shadow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, _mainScroll.EA_Height)];
            shadow.backgroundColor = UIColorFromRGB(0x000000);
            shadow.alpha = 0.4;
            [image1 addSubview:shadow];
            
            
            baseX += 103;
            UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15.5, 20)];
            playImage.image = [UIImage imageNamed:@"profile_play"];
            playImage.EA_CenterX = image1.EA_Width/2;
            playImage.EA_CenterY = image1.EA_Height/2;
            [image1 addSubview:playImage];
        }
        
       
        
    }
    return self;
}

- (void)updateDatas:(NSDictionary *)dict{
    NSArray *images = [dict objectForKey:@"images"];
    [_mainScroll.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *image = (UIImageView *)obj;
        image.image = [UIImage imageNamed:images[idx]];
    }];
}

@end
