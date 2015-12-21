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
- (void)loadStyle1;
- (void)loadStyle2;
- (void)loadStyle3;
- (void)loadStyle4;
@end
