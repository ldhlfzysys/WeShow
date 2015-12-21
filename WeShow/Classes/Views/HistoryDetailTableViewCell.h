//
//  HistoryDetailTableViewCell.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryDetailTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *vipIcon;
@property (nonatomic,strong)UIImageView *likeIcon;
@property (nonatomic,strong)UILabel *likeLabel;

@property (nonatomic,strong)UILabel *commentLabel;

- (void)loadStyle1;
@end
