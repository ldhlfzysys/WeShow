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
        [self addSubview:_mainScroll];
        
        CGFloat baseX = 0;
        for (int i = 0; i < 6; i++) {
            UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(baseX, 0, 100, _mainScroll.EA_Height)];
            image1.backgroundColor = [UIColor grayColor];
            [_mainScroll addSubview:image1];
            baseX += 103;
        }
        
       
        
    }
    return self;
}

@end
