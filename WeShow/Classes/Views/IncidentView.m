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
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowOpacity = 0.95;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfdidClick:)];
        [self addGestureRecognizer:tapGes];
        CGFloat mainImageHeight = (31.0/34.0) * self.EA_Width;
        _mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, mainImageHeight)];
        _mainImage.image = [UIImage imageNamed:@"incident_b1"];
        _mainImage.layer.cornerRadius = 5;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_mainImage.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _mainImage.bounds;
        maskLayer.path = maskPath.CGPath;
        _mainImage.layer.mask = maskLayer;
        [self addSubview:_mainImage];
        
        _redDotImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 16, 8, 8)];
        _redDotImage.image = [UIImage imageNamed:@"map_pull_live"];
        [self addSubview:_redDotImage];
        
        _mediaTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 12, 100, 16)];
        _mediaTypeLabel.text = @"Live";
        _mediaTypeLabel.font = [UIFont systemFontOfSize:16];
        _mediaTypeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_mediaTypeLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _mainImage.EA_Bottom + 14, 300, 18)];
        _titleLabel.text = @"标题";
//        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.font = [UIFont fontWithName:@"Medium-Bold" size:18];
        _titleLabel.textColor = UIColorFromRGB(0x636466);
        [self addSubview:_titleLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _titleLabel.EA_Bottom + 5, 300, 12)];
        _addressLabel.text = @"地址";
        _addressLabel.font = [UIFont systemFontOfSize:12];
//        _addressLabel.font = [UIFont fontWithName:@"Light" size:12];
        _addressLabel.textColor = UIColorFromRGB(0xC4C7CC);
        [self addSubview:_addressLabel];
        
        _distanceIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.EA_Height - 24, 12, 12)];
        _distanceIcon.image = [UIImage imageNamed:@"map_pull_live_yellow"];
        [self addSubview:_distanceIcon];
        
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_distanceIcon.EA_Right + 4, _distanceIcon.EA_Top, 40, 12)];
        _distanceLabel.text = @"100m";
        _distanceLabel.textColor = UIColorFromRGB(0xDCAC5B);
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_distanceLabel];
        
        _memberIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_distanceLabel.EA_Right + 12, _distanceIcon.EA_Top, 12, 12)];
        _memberIcon.image = [UIImage imageNamed:@"map_pull_people"];
        [self addSubview:_memberIcon];
        
        _memberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_memberIcon.EA_Right + 4, _distanceIcon.EA_Top, 40, 12)];
        _memberLabel.text = @"100人";
        _memberLabel.textColor = UIColorFromRGB(0xDCAC5B);
        _memberLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_memberLabel];
        
    }
    return self;
}

-(void)updateDatas:(NSDictionary *)dict{
    NSString *imageName = [dict objectForKey:@"imageName"];
    NSString *mediaLabelStr = [dict objectForKey:@"mediaType"];
    NSString *title = [dict objectForKey:@"title"];
    NSString *address = [dict objectForKey:@"address"];
    NSString *distance = [dict objectForKey:@"distance"];
    NSString *memberNum = [dict objectForKey:@"memberNum"];
    _mainImage.image = [UIImage imageNamed:imageName];
    _mediaTypeLabel.text = mediaLabelStr;
    _titleLabel.text = title;
    _addressLabel.text = address;
    _distanceLabel.text = distance;
    _memberLabel.text = memberNum;
}

- (void)selfdidClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickIncidentView:)]) {
        [self.delegate didClickIncidentView:self];
    }
}

@end
