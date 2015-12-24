//
//  MultiIncidentTableViewCell.h
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiIncidentTableViewCell : UITableViewCell

@property BOOL didShow;

- (void)loadStyle1:(NSDictionary *)dict;
- (void)loadStyle2:(NSDictionary *)dict;
- (void)loadStyle3:(NSDictionary *)dict;
@end
