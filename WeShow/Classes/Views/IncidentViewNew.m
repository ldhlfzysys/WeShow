//
//  IncidentViewNew.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "IncidentViewNew.h"

@implementation IncidentViewNew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfdidClick:)];
        [self addGestureRecognizer:tapGes];

        _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, self.EA_Width)];
        _mainImage.image = [UIImage imageNamed:@"incident_b1"];
        [self addSubview:_mainImage];
        
        _shadowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.EA_Width - 83, self.EA_Width, 83)];
        _shadowImage.backgroundColor = UIColorFromRGB(0x000000);
        _shadowImage.alpha = 0.8;
        [self addSubview:_shadowImage];
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = _headImage.EA_Width/2;
        _headImage.backgroundColor = [UIColor whiteColor];
        _headImage.alpha = 0.8;
        [self addSubview:_headImage];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.EA_Right + 5, 0, 200, 14)];
        _nameLabel.text = @"Janel";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = UIColorFromRGB(0xffffff);
        _nameLabel.EA_CenterY = _headImage.EA_CenterY;
        _nameLabel.alpha = 0.8;
        [self addSubview:_nameLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, self.EA_Width, 18)];
        _titleLabel.text = @"标题";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = UIColorFromRGB(0x636466);
        [_shadowImage addSubview:_titleLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.EA_Bottom + 6, self.EA_Width, 12)];
        _addressLabel.text = @"地址";
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.textColor = UIColorFromRGB(0xC4C7CC);
        [_shadowImage addSubview:_addressLabel];
        
        CGFloat centerX = self.EA_Width/2;
        
        _distanceIcon = [[UIImageView alloc]initWithFrame:CGRectMake(centerX - 62, _addressLabel.EA_Bottom + 13, 12, 12)];
        _distanceIcon.image = [UIImage imageNamed:@"map_pull_live_yellow"];
        [_shadowImage addSubview:_distanceIcon];
        
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_distanceIcon.EA_Right + 4, _distanceIcon.EA_Top, 40, 12)];
        _distanceLabel.text = @"100m";
        _distanceLabel.textColor = UIColorFromRGB(0xDCAC5B);
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        [_shadowImage addSubview:_distanceLabel];
        
        _memberIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_distanceLabel.EA_Right + 12, _distanceIcon.EA_Top, 12, 12)];
        _memberIcon.image = [UIImage imageNamed:@"map_pull_people"];
        [_shadowImage addSubview:_memberIcon];
        
        _memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_memberIcon.EA_Right + 4, _distanceIcon.EA_Top, 40, 12)];
        _memberLabel.text = @"100人";
        _memberLabel.textColor = UIColorFromRGB(0xDCAC5B);
        _memberLabel.font = [UIFont systemFontOfSize:12];
        [_shadowImage addSubview:_memberLabel];
        
    }
    return self;
}

- (void)selfdidClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickIncidentViewNew:)]) {
        [self.delegate didClickIncidentViewNew:self];
    }
}


@end
