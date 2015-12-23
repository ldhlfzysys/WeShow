//
//  UserIncidentTableViewCell.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserIncidentView.h"

@interface UserIncidentTableViewCell : UITableViewCell
@property (nonatomic,strong)UserIncidentView *bgView;
- (void)loadStyle1:(NSDictionary *)dict;
- (void)loadStyle2:(NSDictionary *)dict;
- (void)loadStyle3:(NSDictionary *)dict;
- (void)loadStyle4:(NSDictionary *)dict;
@end
