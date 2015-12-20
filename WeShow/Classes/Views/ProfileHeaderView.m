//
//  ProfileHeaderView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "ProfileHeaderView.h"

@implementation TwoLineButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 16)];
        _numLabel.font = [UIFont systemFontOfSize:16];
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.text = @"123";
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numLabel];
        
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _numLabel.EA_Bottom+6, self.EA_Width, 12)];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = UIColorFromRGB(0x73767f);
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.text = @"观众";
        [self addSubview:_descLabel];
    }
    return self;
}

@end

@implementation ProfileHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0x373b47);
        _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 150)];
        _topImage.backgroundColor = [UIColor grayColor];
        [self addSubview:_topImage];
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 118, 74, 74)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = _headImage.EA_Width/2;
        _headImage.backgroundColor = [UIColor whiteColor];
        [self addSubview:_headImage];
        
        _viewer = [[TwoLineButton alloc]initWithFrame:CGRectMake(_headImage.EA_Right + 18.5, _topImage.EA_Bottom + 8, 60, 60)];
        _viewer.numLabel.text = @"2981";
        _viewer.descLabel.text = @"观众";
        [self addSubview:_viewer];
        
        _follower = [[TwoLineButton alloc]initWithFrame:CGRectMake(_viewer.EA_Right + 37, _topImage.EA_Bottom + 8, 60, 60)];
        _follower.numLabel.text = @"992";
        _follower.descLabel.text = @"关注";
        [self addSubview:_follower];
        
        _history = [[TwoLineButton alloc]initWithFrame:CGRectMake(_follower.EA_Right + 37, _topImage.EA_Bottom + 8, 60, 60)];
        _history.numLabel.text = @"173";
        _history.descLabel.text = @"足迹";
        [self addSubview:_history];
        
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.EA_Height - 33, self.EA_Width - 20, 25)];
        _descLabel.font = [UIFont systemFontOfSize:10];
        _descLabel.numberOfLines = 2;
        _descLabel.textColor = UIColorFromRGB(0xe1ba73);
        _descLabel.text = @"aklsdj fakjsd fkjasdl; fjklas djlkfjjlkfjasdjlkfjasdjlkfjas dkfjkalsdjfklasdl k jfasd alskdj fjsad ";
        [self addSubview:_descLabel];
        
        
    }
    return self;
}

@end
