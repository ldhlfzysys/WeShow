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

- (void)loadStyle1{
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, 95)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _headImage.backgroundColor = [UIColor grayColor];
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.EA_Width/2;
    [bgView addSubview:_headImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.EA_Right +10, 10, self.EA_Width - 90, 12)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = UIColorFromRGB(0x676767);
    _nameLabel.EA_CenterY = _headImage.EA_CenterY;
    _nameLabel.text = @"名字";
    [_nameLabel sizeToFit];
    [bgView addSubview:_nameLabel];
    
    _vipIcon = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.EA_Right + 5, 0, 16, 16)];
    _vipIcon.image = [UIImage imageNamed:@"history_trophy"];
    _vipIcon.EA_Bottom = _nameLabel.EA_Bottom;
    [bgView addSubview:_vipIcon];
    
    _likeLabel = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0, 10, 12)];
    _likeLabel.font = [UIFont systemFontOfSize:12];
    _likeLabel.textColor = UIColorFromRGB(0xc4c7cc);
    _likeLabel.text = @"442";
    _likeLabel.EA_Right = bgView.EA_Right - 30;
    _likeLabel.EA_CenterY = _nameLabel.EA_CenterY;
    [_likeLabel sizeToFit];
    [bgView addSubview:_likeLabel];
    
    _likeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    _likeIcon.image = [UIImage imageNamed:@"history_like"];
    _likeIcon.EA_Right = _likeLabel.EA_Left-4;
    _likeIcon.EA_CenterY = _nameLabel.EA_CenterY;
    [bgView addSubview:_likeIcon];
    
    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeClick)];
    _likeIcon.userInteractionEnabled = YES;
    [_likeIcon addGestureRecognizer:likeTap];
    
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake( 10, 45, self.EA_Width - 20, 50)];
    _commentLabel.font = [UIFont systemFontOfSize:15];
    _commentLabel.textColor = UIColorFromRGB(0x46484b);
    _commentLabel.numberOfLines = 2;
    _commentLabel.text = @"asdlkfj aasdf asd fasd asd fskdjf lkasjdfl kajsdlfk jalskdjf lkasdjflk ajsdlkfj asdlkfja";
    [_commentLabel sizeToFit];
    [bgView addSubview:_commentLabel];
    
    CGFloat baseTop = (bgView.EA_Height - 30 - _commentLabel.EA_Height)/2;
    _commentLabel.EA_Top = baseTop + 30;
}

- (void)likeClick{
    _likeIcon.image = [UIImage imageNamed:@"history_like_highlight"];
    _likeLabel.text = [NSString stringWithFormat:@"%ld",[_likeLabel.text integerValue]+1];
}
@end
