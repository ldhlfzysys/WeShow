//
//  IncidentView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "IncidentView.h"

@implementation IncidentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _redDotImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 16, 8, 8)];
        _redDotImage.image = [UIImage imageNamed:@"map_pull_live"];
    }
    return self;
}

@end
