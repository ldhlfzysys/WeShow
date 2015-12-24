//
//  HistoryDetailTableViewCell.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "HistoryDetailTableViewCell.h"

@implementation HistoryDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColorFromRGB(0x373b47);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    return self;
}

- (void)loadStyle1:(NSDictionary *)dict{
    
    NSString *headImageName = [dict objectForKey:@"headImageName"];
    NSString *name = [dict objectForKey:@"name"];
    NSString *like = [dict objectForKey:@"likeNum"];
    NSString *comment = [dict objectForKey:@"comment"];
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, 95)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _headImage.backgroundColor = [UIColor grayColor];
    _headImage.image = [UIImage imageNamed:headImageName];
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.EA_Width/2;
    [bgView addSubview:_headImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.EA_Right +10, 10, self.EA_Width - 90, 12)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = UIColorFromRGB(0x676767);
    _nameLabel.EA_CenterY = _headImage.EA_CenterY;
    _nameLabel.text = name;
    [_nameLabel sizeToFit];
    [bgView addSubview:_nameLabel];
    
    _vipIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.EA_Right + 5, 0, 16, 16)];
    _vipIcon.image = [UIImage imageNamed:@"history_trophy"];
    _vipIcon.EA_Bottom = _nameLabel.EA_Bottom;
    [bgView addSubview:_vipIcon];
    
    _likeLabel = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0, 10, 12)];
    _likeLabel.font = [UIFont systemFontOfSize:12];
    _likeLabel.textColor = UIColorFromRGB(0xc4c7cc);
    _likeLabel.text = like;
    _likeLabel.EA_Right = bgView.EA_Right - 30;
    _likeLabel.EA_CenterY = _nameLabel.EA_CenterY;
    [_likeLabel sizeToFit];
    [bgView addSubview:_likeLabel];
    
    _likeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    _likeIcon.image = [UIImage imageNamed:@"history_like"];
    _likeIcon.EA_Right = _likeLabel.EA_Left-4;
    _likeIcon.EA_CenterY = _nameLabel.EA_CenterY;
    _likeIcon.userInteractionEnabled = YES;
    [bgView addSubview:_likeIcon];
    
    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeClick)];

    [_likeIcon addGestureRecognizer:likeTap];
    
    UIImageView *mark = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 35, 35)];
    mark.image = [UIImage imageNamed:@"history_mark"];
    [bgView addSubview:mark];

    _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake( 10, 45, self.EA_Width - 20, 50)];
    _commentLabel.font = [UIFont systemFontOfSize:15];
    _commentLabel.textColor = UIColorFromRGB(0x46484b);
    _commentLabel.numberOfLines = 2;
    _commentLabel.text = comment;
    [_commentLabel sizeToFit];
    [bgView addSubview:_commentLabel];
    
    CGFloat baseTop = (bgView.EA_Height - 30 - _commentLabel.EA_Height)/2;
    _commentLabel.EA_Top = baseTop + 30;
}

- (void)likeClick{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        _likeIcon.image = [UIImage imageNamed:@"history_like_highlight"];
        _likeIcon.EA_Top -= 10;
    }completion:^(BOOL finished) {
        _likeIcon.EA_Top += 10;
    }];
    
    _likeLabel.text = [NSString stringWithFormat:@"%ld",[_likeLabel.text integerValue]+1];
    [_likeLabel sizeToFit];
}
@end
