//
//  UserIncidentView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "UserIncidentView.h"

@implementation UserIncidentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0x373b47);
        
        _headBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 40)];
        _headBgImage.image = [UIImage imageNamed:@"feed_mine"];
        [self addSubview:_headBgImage];
        _headBgImage.hidden = YES;
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
        _headImage.backgroundColor = [UIColor whiteColor];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = _headImage.EA_Width/2;
        [self addSubview:_headImage];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick)];
        _headImage.userInteractionEnabled = YES;
        [_headImage addGestureRecognizer:tapGes];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.EA_Right + 6, 2, 200, 14)];
        _nameLabel.textColor = UIColorFromRGB(0x93979a);
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"Janel";
        [self addSubview:_nameLabel];
        
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.EA_Right + 6, _nameLabel.EA_Bottom + 2, 200, 10)];
        _descLabel.textColor = UIColorFromRGB(0x636466);
        _descLabel.font = [UIFont systemFontOfSize:10];
        _descLabel.text = @"Janel";
        [self addSubview:_descLabel];
        
        _lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(24, 30, 2, self.EA_Height - 30)];
        _lineImage.backgroundColor = UIColorFromRGB(0x444a5b);
        [self addSubview:_lineImage];
        
        _followButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 41, 20)];
        [_followButton setBackgroundImage:[UIImage imageNamed:@"feed_follow"] forState:UIControlStateNormal];
        _followButton.EA_CenterY = _headImage.EA_CenterY;
        _followButton.EA_Right = self.EA_Right - 10;
        [_followButton addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followButton];
        
    }
    return self;
}

- (void)followClick{
    [_followButton setBackgroundImage:[UIImage imageNamed:@"feed_follow_highlight"] forState:UIControlStateNormal];
}

- (void)headClick{
    self.headImageClick();
}

- (void)hughMode{
    _headBgImage.hidden = NO;
    self.followButton.hidden = YES;
    self.headImage.EA_Width = self.headImage.EA_Height = 40;
    self.headImage.layer.cornerRadius = _headImage.EA_Width/2;
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.descLabel.textColor = UIColorFromRGB(0xdeac5b);
    self.lineImage.EA_Top = 40;
    self.lineImage.EA_Height = self.EA_Height - 40;
    self.nameLabel.EA_Left = self.descLabel.EA_Left = _headImage.EA_Right + 6;
    
    self.nameLabel.EA_Top = 3;
    self.descLabel.EA_Top = self.nameLabel.EA_Bottom + 7 ;
    self.descLabel.text = @"下拉刷新18条新内容";
}

- (void)normalMode{
    
}

@end
