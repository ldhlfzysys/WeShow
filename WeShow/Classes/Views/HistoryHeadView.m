//
//  HistoryHeadView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryHeadView.h"

@implementation HeadNameView
//100*100
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 70, 70)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = _headImage.EA_Width/2;
        _headImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_headImage];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _headImage.EA_Bottom + 10, 0, 12)];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = UIColorFromRGB(0x46484b);
        _nameLabel.text = @"Janel";
        [_nameLabel sizeToFit];
        [self addSubview:_nameLabel];
        
        _vipIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 14)];
        _vipIcon.image = [UIImage imageNamed:@"history_trophy"];
        _vipIcon.EA_Left = _nameLabel.EA_Right +2;
        _vipIcon.EA_Bottom = _nameLabel.EA_Bottom;
        [self addSubview:_vipIcon];
        
        CGFloat baseX = (70 - _nameLabel.EA_Width - _vipIcon.EA_Width)/2;
        _nameLabel.EA_Left = baseX + 15;
        _vipIcon.EA_Left = _nameLabel.EA_Right +2;
   
    }
    return self;
}

@end

@implementation HistoryHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 442)];
        _topImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_topImage];
        
        _vedioImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, _topImage.EA_Bottom - 75, 100, 150)];
        _vedioImage.backgroundColor = [UIColor brownColor];
        [self addSubview:_vedioImage];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_vedioImage.EA_Right + 10, _topImage.EA_Bottom + 14, self.EA_Width - _vedioImage.EA_Right - 20, 18)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = UIColorFromRGB(0x636466);
        _titleLabel.text = @"标题";
        [self addSubview:_titleLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.EA_Left, _titleLabel.EA_Bottom + 6, self.EA_Width - 90, 12)];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = UIColorFromRGB(0xc4c7cc);
        _addressLabel.text = @"地址";
        [self addSubview:_addressLabel];
        
        _timeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.EA_Left, _addressLabel.EA_Bottom+12, 12, 12)];
        _timeIcon.image = [UIImage imageNamed:@"history_time"];
        [self addSubview:_timeIcon];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeIcon.EA_Right + 4, _addressLabel.EA_Bottom+13, 60, 12)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = UIColorFromRGB(0xdcac5b);
        _timeLabel.text = @"8h 24m";
        [self addSubview:_timeLabel];
        
        
        _peopleNumIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_timeLabel.EA_Right + 12, _addressLabel.EA_Bottom+13, 12, 12)];
        _peopleNumIcon.image = [UIImage imageNamed:@"map_pull_people"];
        [self addSubview:_peopleNumIcon];
        
        _peopleNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(_peopleNumIcon.EA_Right + 4, _addressLabel.EA_Bottom+13, 60, 12)];
        _peopleNumLabel.font = [UIFont systemFontOfSize:12];
        _peopleNumLabel.textColor = UIColorFromRGB(0xdcac5b);
        _peopleNumLabel.text = @"3821";
        [self addSubview:_peopleNumLabel];
        
        _createManView = [[OnelineView alloc]initWithFrame:CGRectMake(20, _vedioImage.EA_Bottom + 23, 110, 12)];
        _createManView.nameLabel.text = @"创建者";
        [self addSubview:_createManView];
        
        _createHeadView = [[HeadNameView alloc]initWithFrame:CGRectMake(15, _createManView.EA_Bottom, 100, 100)];
        [self addSubview:_createHeadView];
        
        _joinManView = [[OnelineView alloc]initWithFrame:CGRectMake(_createManView.EA_Right+16, _vedioImage.EA_Bottom + 23, self.EA_Width - _createManView.EA_Right-16, 12)];
        _joinManView.nameLabel.text = @"发布者";
        [self addSubview:_joinManView];
        
        
        _multiHeadScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(147.5, _joinManView.EA_Bottom, self.EA_Width - 147.5, 100)];
        _multiHeadScroll.contentSize = CGSizeMake(400, 130);

        [self addSubview:_multiHeadScroll];
        
        CGFloat baseX = 0;
        for (int i = 0; i<3; i ++) {
            HeadNameView *eV = [[HeadNameView alloc]initWithFrame:CGRectMake(baseX, 0, 100,100)];
            [_multiHeadScroll addSubview:eV];
            baseX += 100;
        }
        
        _niceView = [[OnelineView alloc]initWithFrame:CGRectMake(20, _createManView.EA_Bottom + 124, self.EA_Width - 20, 12)];
        _niceView.nameLabel.text = @"精彩内容";
        [self addSubview:_niceView];
        
        _niceScroll = [[MultiIncidentScrollView alloc]initWithFrame:CGRectMake(20, _niceView.EA_Bottom + 11, self.EA_Width - 20, 150)];
        [self addSubview:_niceScroll];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(130, _createManView.EA_Bottom - 6 , 1, 110)];
        line.backgroundColor = UIColorFromRGB(0xdddee2);
        [self addSubview:line];
        
        
        
        
        
    }
    return self;
}
@end
