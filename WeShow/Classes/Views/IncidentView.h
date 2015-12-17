//
//  IncidentView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "EABaseCardView.h"


@class IncidentView;
@protocol IncidentViewDelegate <NSObject>

- (void)didClickIncidentView:(IncidentView *)inview;

@end

@interface IncidentView : EABaseCardView
@property (nonatomic, weak)id<IncidentViewDelegate> delegate;
@property (nonatomic, strong)UIImageView *redDotImage;
@property (nonatomic, strong)UILabel *mediaTypeLabel;
@property (nonatomic, strong)UIImageView *mainImage;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UIImageView *distanceIcon;
@property (nonatomic, strong)UILabel *distanceLabel;
@property (nonatomic, strong)UIImageView *memberIcon;
@property (nonatomic, strong)UILabel *memberLabel;

@end
