//
//  MultiIncidentView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "ImageMultiLineIncident.h"

@implementation ImageMultiLineIncident

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 61, 61)];
        _headView.backgroundColor = [UIColor greenColor];
        [self addSubview:_headView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headView.EA_Right + 10, 10, self.EA_Width - 90, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = UIColorFromRGB(0x636466);
        _titleLabel.text = @"时间标题";
        [self addSubview:_titleLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headView.EA_Right + 10, 6, self.EA_Width - 90, 10)];
        _addressLabel.font = [UIFont systemFontOfSize:10];
        _addressLabel.textColor = UIColorFromRGB(0xc4c7cc);
        _addressLabel.text = @"地址";
        [self addSubview:_addressLabel];
        
        _timeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_headView.EA_Right + 10, _addressLabel.EA_Bottom+13, 12, 12)];
        _timeIcon.image = [UIImage imageNamed:@"history_time"];
        [self addSubview:_timeIcon];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeIcon.EA_Right + 4, _addressLabel.EA_Bottom+13, 60, 12)];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = UIColorFromRGB(0xdcac5b);
        _addressLabel.text = @"8h 24m";
        [self addSubview:_addressLabel];
        
        
        _peopleNumIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_timeLabel.EA_Right + 12, _addressLabel.EA_Bottom+13, 12, 12)];
        _peopleNumIcon.image = [UIImage imageNamed:@"map_pull_people"];
        [self addSubview:_peopleNumIcon];
        
        _peopleNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(_peopleNumIcon.EA_Right + 4, _addressLabel.EA_Bottom+13, 60, 12)];
        _peopleNumLabel.font = [UIFont systemFontOfSize:12];
        _peopleNumLabel.textColor = UIColorFromRGB(0xdcac5b);
        _peopleNumLabel.text = @"3821";
        [self addSubview:_peopleNumLabel];
        
        
        
    }
    return self;
}

@end
