//
//  IncidentViewNew.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IncidentViewNew;
@protocol IncidentViewNewDelegate <NSObject>

- (void)didClickIncidentViewNew:(IncidentViewNew *)inview;

@end

@interface IncidentViewNew : UIView
@property (nonatomic, weak)id<IncidentViewNewDelegate> delegate;
@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UIImageView *mainImage;
@property (nonatomic, strong)UIImageView *shadowImage;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UIImageView *distanceIcon;
@property (nonatomic, strong)UILabel *distanceLabel;
@property (nonatomic, strong)UIImageView *memberIcon;
@property (nonatomic, strong)UILabel *memberLabel;
-(void)updateDatas:(NSDictionary *)dict;
@end
