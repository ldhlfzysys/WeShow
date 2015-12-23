//
//  HistoryHeadView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnelineView.h"
#import "MultiIncidentScrollView.h"

@interface HeadNameView : UIView
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *vipIcon;
@end

@interface HistoryHeadView : UIView
@property (nonatomic,strong)UIImageView *topImage;
@property (nonatomic,strong)UIImageView *vedioImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIImageView *timeIcon;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *peopleNumIcon;
@property (nonatomic,strong)UILabel *peopleNumLabel;
@property (nonatomic,strong)OnelineView *createManView;
@property (nonatomic,strong)OnelineView *joinManView;
@property (nonatomic,strong)OnelineView *niceView;
@property (nonatomic,strong)UIScrollView *multiHeadScroll;
@property (nonatomic,strong)HeadNameView *createHeadView;
@property (nonatomic,strong)MultiIncidentScrollView *niceScroll;

- (void)updateDatas:(NSDictionary *)dict;

@end
