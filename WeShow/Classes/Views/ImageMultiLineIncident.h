//
//  MultiIncidentView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMultiLineIncident : UIView
@property (nonatomic,strong)UIImageView *headView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIImageView *timeIcon;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *peopleNumIcon;
@property (nonatomic,strong)UILabel *peopleNumLabel;
@property (nonatomic,strong)UILabel *lineLabel;
@property (nonatomic,strong)UIImageView *lineImage;
@property (nonatomic,strong)UIScrollView *mainScroll;

- (void)updateDatas:(NSDictionary *)dict;
@end
