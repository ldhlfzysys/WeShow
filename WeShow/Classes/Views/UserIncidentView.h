//
//  UserIncidentView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^headImageClickBlock)(void);

@interface UserIncidentView : UIView
@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UIImageView *headBgImage;
@property (nonatomic, copy)headImageClickBlock headImageClick;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *descLabel;
@property (nonatomic, strong)UIImageView *lineImage;
@property (nonatomic, strong)UIButton *followButton;
- (void)hughMode;
- (void)normalMode;
@end
